Return-Path: <linux-fpga+bounces-1410-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02A8C31E33
	for <lists+linux-fpga@lfdr.de>; Tue, 04 Nov 2025 16:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D88B18906A1
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Nov 2025 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247AB328B47;
	Tue,  4 Nov 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="RU2HExvn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp94.iad3a.emailsrvr.com (smtp94.iad3a.emailsrvr.com [173.203.187.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BA2F617D
	for <linux-fpga@vger.kernel.org>; Tue,  4 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270611; cv=none; b=GdVApsQWqxeME/2G6ehdh92/6lnJ93no9TmzeUD/Kn1+7T1b5+fD493JweMj4kEuuBsoNswSpnu8exi+I+cn9hM4nnxoJYWcqhp66AZctbYZOT7Y4vRXTt8lxdOMjNChyemTPxfqNw7rGkK6KI1tu27ZGbIZC0B3sJLtjNtYN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270611; c=relaxed/simple;
	bh=oHrVtgxgv0/yF2HOJsdt390wQH50oI5HLTgStZWgqwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0l8eisdxFWgSsRVMtbvZ5SU3w+mZta8ShV/K5ag30MdKPQZFR0gBEWbii4MXy46JZ2MU4y9bIUpQXyKO1+eJziUBFpsWfRzlFP6ptf8qH198jnzyboozmKBWbEQ2D2dSUOfdfvF9T8xAC9L4W3uoIUuqHEiH3yMPCtSBLeAoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=RU2HExvn; arc=none smtp.client-ip=173.203.187.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762270231;
	bh=oHrVtgxgv0/yF2HOJsdt390wQH50oI5HLTgStZWgqwU=;
	h=From:To:Subject:Date:From;
	b=RU2HExvnIk0tapMp5+Rn2ClhorovvFEV52JtnTMOLpDJZCdlh3/lQLPQmNAofoV8t
	 17HkpRJm4+5HOsnvGe8RB7QRNbSAlRsNaAn4gSK6iIeLc+QYizqn9Xab2818JqGKnF
	 C3FmJJ9SWR+EG4nyAzAM15j33WUDLShFuL7eWfhE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CBB6B55BE;
	Tue,  4 Nov 2025 10:30:30 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 3/4] fpga: manager: Add dummy definitions of API functions
Date: Tue,  4 Nov 2025 15:27:04 +0000
Message-ID: <20251104153013.154463-4-abbotti@mev.co.uk>
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
X-Classification-ID: 7af648e7-5513-437d-9d71-25d484e80853-4-1

Add dummy versions of the FPGA manager API functions for build testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 include/linux/fpga/fpga-mgr.h | 95 ++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0d4fe068f3d8..bc77d71c8dd7 100644
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
+#ifdef CONFIG_FPGA
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


