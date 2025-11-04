Return-Path: <linux-fpga+bounces-1411-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF81C31E4B
	for <lists+linux-fpga@lfdr.de>; Tue, 04 Nov 2025 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A773B92AC
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Nov 2025 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2232E696;
	Tue,  4 Nov 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="rlb4D83n"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp94.iad3a.emailsrvr.com (smtp94.iad3a.emailsrvr.com [173.203.187.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBA328B6A
	for <linux-fpga@vger.kernel.org>; Tue,  4 Nov 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270613; cv=none; b=oYpUwKQ+yUXrQjaiGFGAaVEk4aVzpG0kz1tbADkXeRGJ8hPAryqFLidly5gm8Vv4JsOXQ+43iWDiaf5SsR35IJkgxIKhrGXsAG9B90uMoVQvQSScR6PZQe5Xr+R96SpNbrfTFyldxyfXzN9mva0yefeznAZcXVDXYpPAWxQwJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270613; c=relaxed/simple;
	bh=zJrTM+9Q+tb4LzRuOVK4bkpRachZdbEALEQL41CkUOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW2b8z2K6CmWrXOPK24Jucom+droru9za1RAJlEvWK6rCNhJBaBrdP5MDxi/UOHE6TFXWD2qXayqfTFyn5ut2vb46sT0/y3L7lyvma6gqVWefSj5VJAjdm1cgNa/3Is/y3YKcbc8tsalpTtSIBknIJMFSc23aKagfVCy9qXdejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=rlb4D83n; arc=none smtp.client-ip=173.203.187.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762270230;
	bh=zJrTM+9Q+tb4LzRuOVK4bkpRachZdbEALEQL41CkUOY=;
	h=From:To:Subject:Date:From;
	b=rlb4D83n1miqHZelsautZ7OFpDBXmOow4hSuSJcGx72JCrAFd4CmJ+Zzmw38Ug6sZ
	 NAciu2Ws/xjU2nqR0VcfOk+wUVnFh30xcpQR4BbVxadLUrdEkbqj6oluixY8At9pQy
	 UImJBpafES6tJPkh4U1tuKISMQQ8qa7+SsITo20Q=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id AC1F05579;
	Tue,  4 Nov 2025 10:30:29 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 2/4] fpga: bridge: Add dummy definitions of API functions
Date: Tue,  4 Nov 2025 15:27:03 +0000
Message-ID: <20251104153013.154463-3-abbotti@mev.co.uk>
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
X-Classification-ID: 7af648e7-5513-437d-9d71-25d484e80853-3-1

Add dummy versions of the FPGA bridge API functions for build testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 include/linux/fpga/fpga-bridge.h | 75 +++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 94c4edd047e5..107e97adcc7c 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -5,6 +5,7 @@
 
 #include <linux/device.h>
 #include <linux/fpga/fpga-mgr.h>
+#include <linux/err.h>
 
 struct fpga_bridge;
 
@@ -63,6 +64,10 @@ struct fpga_bridge {
 
 #define to_fpga_bridge(d) container_of(d, struct fpga_bridge, dev)
 
+#define fpga_bridge_register(parent, name, br_ops, priv) \
+	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
+
+#ifdef CONFIG_FPGA_BRIDGE
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *node,
 				       struct fpga_image_info *info);
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
@@ -81,12 +86,78 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
-#define fpga_bridge_register(parent, name, br_ops, priv) \
-	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
 struct fpga_bridge *
 __fpga_bridge_register(struct device *parent, const char *name,
 		       const struct fpga_bridge_ops *br_ops, void *priv,
 		       struct module *owner);
 void fpga_bridge_unregister(struct fpga_bridge *br);
 
+#else
+static inline struct fpga_bridge *
+of_fpga_bridge_get(struct device_node *node, struct fpga_image_info *info)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct fpga_bridge *
+fpga_bridge_get(struct device *dev, struct fpga_image_info *info)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void fpga_bridge_put(struct fpga_bridge *bridge)
+{
+}
+
+static inline int fpga_bridge_enable(struct fpga_bridge *bridge)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int fpga_bridge_disable(struct fpga_bridge *bridge)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int fpga_bridges_enable(struct list_head *bridge_list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int fpga_bridges_disable(struct list_head *bridge_list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void fpga_bridges_put(struct list_head *bridge_list)
+{
+}
+
+static inline int fpga_bridge_get_to_list(struct device *dev,
+					  struct fpga_image_info *info,
+					  struct list_head *bridge_list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int of_fpga_bridge_get_to_list(struct device_node *np,
+					     struct fpga_image_info *info,
+					     struct list_head *bridge_list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct fpga_bridge *
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops, void *priv,
+		       struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void fpga_bridge_unregister(struct fpga_bridge *br)
+{
+}
+#endif
+
 #endif /* _LINUX_FPGA_BRIDGE_H */
-- 
2.51.0


