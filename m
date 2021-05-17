Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F143822C7
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhEQCeM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:12 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:35792 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhEQCeJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:09 -0400
Received: by mail-pj1-f41.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso4706067pjb.0
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0btgXLjqzTnoe7nolXFIuQ+q6HadfQT66f7WbOwLQgM=;
        b=LKxblQ01hYf3tKOapkQ4Jg8yuPzcO/b5NZatx1blOzGAxv5DvCbDCFvx8ovnbeoiNt
         Lvea/eqX0RALE++Rz9EZSTE/wqGwr7LVPN8RPElmdAqPcvH1Fxk4LdvO3rYv9IccIhXf
         ZI43EC/SFaS8jmSZRbYavUn/oxTUpFkszhRmvSageRLA66KYIhIE7rqA5crcL5OrSFBP
         vwlR+rzuvVTpdhi2u+/Aztbi1YZjRVx+Q6iE19zvmJuu6oCZZ5knkYxhZa7LVQypl+tJ
         ehxut6DoSa0otW/FeJO4rH7UHnD+XchwYjkK6e0WNNiOpwmJRWpIKh9iNcSjgki69HQ1
         EzNg==
X-Gm-Message-State: AOAM532ZSpz3PHrOX93cV14hkidNPxW8WnlU7QC7VLWQnDM3INp+PIRq
        y/lXFmkqIFfi6OCNVDYc51I=
X-Google-Smtp-Source: ABdhPJyot9VxIL2bavZ6WpHvKbtPt7qlIVVssPYASSg5auIvqh3ZcEbi7QcNmG8lBzKk93nDYnEyaQ==
X-Received: by 2002:a17:902:bcc7:b029:ed:6f73:ffc4 with SMTP id o7-20020a170902bcc7b02900ed6f73ffc4mr57504712pls.1.1621218772670;
        Sun, 16 May 2021 19:32:52 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o3sm9039050pgh.22.2021.05.16.19.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:52 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 05/12] fpga: sec-mgr: expose sec-mgr update size
Date:   Sun, 16 May 2021 19:31:53 -0700
Message-Id: <20210517023200.52707-6-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Extend the FPGA Security Manager class driver to include
an update/remaining_size sysfs node that can be read to
determine how much data remains to be transferred to the
secure update engine. This file can be used to monitor
progress during the "writing" phase of an update.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr | 11 +++++++++++
 drivers/fpga/fpga-sec-mgr.c                        | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index 24890d04521f..c5d0b9d7c7e4 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -28,6 +28,17 @@ Description:	Read-only. Returns a string describing the current
 		as it will be signaled by sysfs_notify() on each
 		state change.
 
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/remaining_size
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns the size of data that remains to
+		be written to the secure update engine. The size
+		value is initialized to the full size of the file
+		image and the value is updated periodically during
+		the "writing" phase of the update.
+		Format: "%u".
+
 What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
 Date:		June 2021
 KernelVersion:	5.14
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 903385779a1f..bc6b35cc7237 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -198,6 +198,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(error);
 
+static ssize_t remaining_size_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+
+	return sysfs_emit(buf, "%u\n", smgr->remaining_size);
+}
+static DEVICE_ATTR_RO(remaining_size);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -234,6 +243,7 @@ static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
+	&dev_attr_remaining_size.attr,
 	NULL,
 };
 
-- 
2.31.1

