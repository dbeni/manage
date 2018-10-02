using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace manage.Models
{
    public partial class exerciseContext : DbContext
    {
        public exerciseContext()
        {
        }

        public exerciseContext(DbContextOptions<exerciseContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Assign> Assign { get; set; }
        public virtual DbSet<Employee> Employee { get; set; }
        public virtual DbSet<Manage> Manage { get; set; }
        public virtual DbSet<Report> Report { get; set; }
        public virtual DbSet<Task> Task { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Data Source=IRISPC;Initial Catalog=exercise;Integrated Security=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Assign>(entity =>
            {
                entity.HasKey(e => new { e.IdCreator, e.IdAssignee, e.IdTask });

                entity.ToTable("assign");

                entity.Property(e => e.IdCreator).HasColumnName("idCreator");

                entity.Property(e => e.IdAssignee).HasColumnName("idAssignee");

                entity.Property(e => e.IdTask).HasColumnName("idTask");

                entity.HasOne(d => d.IdAssigneeNavigation)
                    .WithMany(p => p.AssignIdAssigneeNavigation)
                    .HasForeignKey(d => d.IdAssignee)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_assign_employee1");

                entity.HasOne(d => d.IdCreatorNavigation)
                    .WithMany(p => p.AssignIdCreatorNavigation)
                    .HasForeignKey(d => d.IdCreator)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_assign_employee");

                entity.HasOne(d => d.IdTaskNavigation)
                    .WithMany(p => p.Assign)
                    .HasForeignKey(d => d.IdTask)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_assign_task");
            });

            modelBuilder.Entity<Employee>(entity =>
            {
                entity.HasKey(e => e.IdEmployee);

                entity.ToTable("employee");

                entity.Property(e => e.IdEmployee).HasColumnName("idEmployee");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasColumnName("firstName")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasColumnName("lastName")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Position)
                    .IsRequired()
                    .HasColumnName("position")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Picture)
                    .HasColumnName("picture")
                    .HasColumnType("image");
            });

            modelBuilder.Entity<Manage>(entity =>
            {
                entity.HasKey(e => new { e.IdManager, e.IdManaged });

                entity.ToTable("manage");

                entity.Property(e => e.IdManager).HasColumnName("idManager");

                entity.Property(e => e.IdManaged).HasColumnName("idManaged");

                entity.HasOne(d => d.IdManagedNavigation)
                    .WithMany(p => p.ManageIdManagedNavigation)
                    .HasForeignKey(d => d.IdManaged)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_manage_employee1");

                entity.HasOne(d => d.IdManagerNavigation)
                    .WithMany(p => p.ManageIdManagerNavigation)
                    .HasForeignKey(d => d.IdManager)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_manage_employee");
            });

            modelBuilder.Entity<Report>(entity =>
            {
                entity.HasKey(e => e.IdReport);

                entity.ToTable("report");

                entity.Property(e => e.IdReport).HasColumnName("idReport");

                entity.Property(e => e.IdReportCreator).HasColumnName("idReportCreator");

                entity.Property(e => e.ReportContent)
                    .IsRequired()
                    .HasColumnName("reportContent")
                    .HasColumnType("text");

                entity.Property(e => e.ReportDate)
                    .HasColumnName("reportDate")
                    .HasColumnType("date");

                entity.HasOne(d => d.IdReportCreatorNavigation)
                    .WithMany(p => p.Report)
                    .HasForeignKey(d => d.IdReportCreator)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_report_report");
            });

            modelBuilder.Entity<Task>(entity =>
            {
                entity.HasKey(e => e.IdTask);

                entity.ToTable("task");

                entity.Property(e => e.IdTask).HasColumnName("idTask");

                entity.Property(e => e.AssignDate)
                    .HasColumnName("assignDate")
                    .HasColumnType("date");

                entity.Property(e => e.DueDate)
                    .HasColumnName("dueDate")
                    .HasColumnType("date");

                entity.Property(e => e.TaskDescription)
                    .IsRequired()
                    .HasColumnName("taskDescription")
                    .HasColumnType("text");
            });
        }
    }
}
