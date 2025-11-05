Return-Path: <linux-fpga+bounces-1422-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA2C35B92
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 13:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B6566C54
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FAE315D5E;
	Wed,  5 Nov 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Had39oLc"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp115.iad3b.emailsrvr.com (smtp115.iad3b.emailsrvr.com [146.20.161.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AD315D30;
	Wed,  5 Nov 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347400; cv=none; b=YPfFY31QRvQWaZgaZfEMJXnfZT4hUPLiOGTsLRkh0QaorApqXMcpRockOxca7tf7bsft3XslZYQtwRyl9/2bbBdlL9VmWqXbtQb0MY0QdmQY037JpwUBbEmxYx+An/nC7Z1A9+1e/iDe9XotwWOGPUcaj7aVuqxRsCZTyUpSP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347400; c=relaxed/simple;
	bh=c8AZr5V7Puua++C2Q8ZL9jM1MjDiOYoajIlafmk2BPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvuSkuMRIzHkcQFnw5xMnWNu4EZQlQ2b+K0RyEGVREnJO2MivVC137AkAaM99yRK/QWDef537ueu0H6bLT6nPlrKafVO6Xtz9IwxiiNC0Xmm4BDUBxUEuy6SUfmNvaxFAX100IoFXGvpuL1dnkGWWWWxqvWcZzVlWEKcjL2Updw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Had39oLc; arc=none smtp.client-ip=146.20.161.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762346285;
	bh=c8AZr5V7Puua++C2Q8ZL9jM1MjDiOYoajIlafmk2BPY=;
	h=From:To:Subject:Date:From;
	b=Had39oLc2cLo3yUOTFSDNHBMnpxwtWGFPPI6hiGW7zA2+Xi11V0Wwvl2TKC9MPmdk
	 S/llbpGnSMNxAPuWpGfo/l1xZQciQDQpW2XHH8f7GFxojO4Mh3gxvnjildHZ1r7cSM
	 vKMBZOTkPOeabkeLnyztYVL18UBqD/rCNk3QdOyQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4C0DA60337;
	Wed,  5 Nov 2025 07:38:04 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v2 3/4] fpga: manager: Add dummy definitions of API functions
Date: Wed,  5 Nov 2025 12:31:07 +0000
Message-ID: <20251105123752.93672-4-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105123752.93672-1-abbotti@mev.co.uk>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
 <20251105123752.93672-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 2331ede2-2f65-45fd-b71e-e0d81416256f-4-1

Add dummy versions of the FPGA manager API functions for build testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct conditional compilation test for FPGA_MGR tristate
    configuration.
---
 include/linux/fpga/fpga-mgr.h | 95 ++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0d4fe068f3d8..38a139edc29c 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -10,6 +10,7 @@
 
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/err.h>
 
 struct fpga_manager;
 struct sg_table;
@@ -217,6 +218,19 @@ struct fpga_manager {
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
 
+#define fpga_mgr_register_full(parent, info) \
+	__fpga_mgr_register_full(parent, info, THIS_MODULE)
+
+#define fpga_mgr_register(parent, name, mops, priv) \
+	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
+
+#define devm_fpga_mgr_register_full(parent, info) \
+	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
+
+#define devm_fpga_mgr_register(parent, name, mops, priv) \
+	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
+
+#if IS_ENABLED(CONFIG_FPGA)
 struct fpga_image_info *fpga_image_info_alloc(struct device *dev);
 
 void fpga_image_info_free(struct fpga_image_info *info);
@@ -232,30 +246,95 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
-#define fpga_mgr_register_full(parent, info) \
-	__fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
 __fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
 			 struct module *owner);
 
-#define fpga_mgr_register(parent, name, mops, priv) \
-	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
 __fpga_mgr_register(struct device *parent, const char *name,
 		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
 
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
-#define devm_fpga_mgr_register_full(parent, info) \
-	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
 __devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
 			      struct module *owner);
-#define devm_fpga_mgr_register(parent, name, mops, priv) \
-	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
 __devm_fpga_mgr_register(struct device *parent, const char *name,
 			 const struct fpga_manager_ops *mops, void *priv,
 			 struct module *owner);
 
+#else
+static inline struct fpga_image_info *fpga_image_info_alloc(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void fpga_image_info_free(struct fpga_image_info *info)
+{
+}
+
+static inline int fpga_mgr_load(struct fpga_manager *mgr,
+				struct fpga_image_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int fpga_mgr_lock(struct fpga_manager *mgr)
+{
+	return 0;
+}
+
+static inline void fpga_mgr_unlock(struct fpga_manager *mgr)
+{
+}
+
+static inline struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct fpga_manager *fpga_mgr_get(struct device *dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void fpga_mgr_put(struct fpga_manager *mgr)
+{
+}
+
+static inline struct fpga_manager *
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct fpga_manager *
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void fpga_mgr_unregister(struct fpga_manager *mgr)
+{
+}
+
+static inline struct fpga_manager *
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct fpga_manager *
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif
+
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.51.0


