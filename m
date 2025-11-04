Return-Path: <linux-fpga+bounces-1407-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17441C31DAB
	for <lists+linux-fpga@lfdr.de>; Tue, 04 Nov 2025 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8BF34F0A3A
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Nov 2025 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57B626A1BE;
	Tue,  4 Nov 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Gkrwou6W"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp89.iad3a.emailsrvr.com (smtp89.iad3a.emailsrvr.com [173.203.187.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41592116E9
	for <linux-fpga@vger.kernel.org>; Tue,  4 Nov 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270237; cv=none; b=seDnQ/PorTvYvXhRYOqoI4jD1KJymG3n287oHSg2VPUhaalkVDSLgigLNWecf3FiggBkDBjtWnlKjHoepAS/h0fa4AaO+OyhmmsRMzEK94RNfwFsvHdB7eOSBkBwVFVqTqpvr+J/OfZP1wHFvjb2T6VCP6zmx1Ph4eR8go+bbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270237; c=relaxed/simple;
	bh=q5BXmQyABzZtTUsmyyPhSP2uIiu39uFKL6bnKo8+Rcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=konWxdZe2mzzVY//dJ1pwpZihkSWdEW8icCBHYOFOzfehVU6gSqkDqSClk0WXZUA8yYuFuBel1woqWeGrP0KGYWWMg2ETk8FtsGm9bDh9ok0D8wC3/AzfLIhdPgdJgOldmsrbSnFsiV+UkqBV+U3NEMm6oJ0e9mH+Si97Zzz5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Gkrwou6W; arc=none smtp.client-ip=173.203.187.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762270232;
	bh=q5BXmQyABzZtTUsmyyPhSP2uIiu39uFKL6bnKo8+Rcc=;
	h=From:To:Subject:Date:From;
	b=Gkrwou6WRybb1YsE7j820UhLyH6OiuOVvY4SodJA695n5pwsJkkOdcKmvJr0HZJLn
	 4JOgasESoCqw9aIk1TlmDaCuD6kk6TDT/FjNJIernCKGbgoJBI/nBz/y5GApTf44dO
	 7HnXPyRy7cQrMKQNmXRbeuKnfo4LEjWznAS/v3U8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id F064C55B9;
	Tue,  4 Nov 2025 10:30:31 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4/4] fpga: region: Add dummy definitions of API functions
Date: Tue,  4 Nov 2025 15:27:05 +0000
Message-ID: <20251104153013.154463-5-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104153013.154463-1-abbotti@mev.co.uk>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 7af648e7-5513-437d-9d71-25d484e80853-5-1

Add dummy definitions of the FPGA region API functions for build
testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 include/linux/fpga/fpga-region.h | 44 +++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 5fbc05fe70a6..db4c7c1b9151 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
+#include <linux/err.h>
 
 struct fpga_region;
 
@@ -54,23 +55,58 @@ struct fpga_region {
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
 
+#define fpga_region_register_full(parent, info) \
+	__fpga_region_register_full(parent, info, THIS_MODULE)
+
+#define fpga_region_register(parent, mgr, get_bridges) \
+	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
+
+#ifdef CONFIG_FPGA_REGION
 struct fpga_region *
 fpga_region_class_find(struct device *start, const void *data,
 		       int (*match)(struct device *, const void *));
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-#define fpga_region_register_full(parent, info) \
-	__fpga_region_register_full(parent, info, THIS_MODULE)
 struct fpga_region *
 __fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
 			    struct module *owner);
 
-#define fpga_region_register(parent, mgr, get_bridges) \
-	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
 struct fpga_region *
 __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
 		       int (*get_bridges)(struct fpga_region *), struct module *owner);
 void fpga_region_unregister(struct fpga_region *region);
 
+#else
+static inline struct fpga_region *
+fpga_region_class_find(struct device *start, const void *data,
+		       int (*match)(struct device *, const void *))
+{
+	return NULL;
+}
+
+static inline int fpga_region_program_fpga(struct fpga_region *region)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct fpga_region *
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct fpga_region *
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void fpga_region_unregister(struct fpga_region *region)
+{
+}
+#endif
+
 #endif /* _FPGA_REGION_H */
-- 
2.51.0


