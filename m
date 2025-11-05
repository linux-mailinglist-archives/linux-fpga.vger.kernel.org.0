Return-Path: <linux-fpga+bounces-1420-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A8C35B0C
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CE34E944
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE3316193;
	Wed,  5 Nov 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="l7fZ0Y5z"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp112.iad3b.emailsrvr.com (smtp112.iad3b.emailsrvr.com [146.20.161.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AD2FCC02;
	Wed,  5 Nov 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346799; cv=none; b=ay1ro0l9Koqt+IWnHsXE4UrAmCrGv4wT+NM5YCTolJcSBn86YQhBKGSwY+z/rlaXkFs6xSz+DUWXzjz+TKPR1JjbZ5WVKHEKPI2jd+X0CbdvhXoIPM+B72HBw11RnQmGKvFQfAxjg65B3/OBl3oZIKfoek9hap2NoCRvElC/4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346799; c=relaxed/simple;
	bh=ZwmnDZ5ayQjRuT7yqCFIoXAkX0uCbm4SgxOHqVMRlIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfTc6GTSygJwbRDSM5rQfeYAHISF9d6hdvjmc3GodfM55ZOebsElIof7Cph66RSwNhGvodCSrzu52PA2t3IaphkSelv8QujRgqtL9sfU8ZQ/8JCfYO2LXBHIa9IJoY7NXKMGR/87HmhFA2zY5oui81uWcZdLu87hmUvQJzUX88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=l7fZ0Y5z; arc=none smtp.client-ip=146.20.161.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762346284;
	bh=ZwmnDZ5ayQjRuT7yqCFIoXAkX0uCbm4SgxOHqVMRlIE=;
	h=From:To:Subject:Date:From;
	b=l7fZ0Y5zloCa3oCAbhrCAjpQTVfKZpWBY59MlBtl8dObYr5DSIkW01LLGPNLV2mBB
	 8lhXQNScm34EoeCDcKcOXKlOahI13SIsxdPUJZMC/oVw6se1crWDVlL3JHgKLzY+Vy
	 0nu1hiJT+13e/dS5przOKvTJlBWa8fan5KH6gZBo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 2491160336;
	Wed,  5 Nov 2025 07:38:03 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v2 2/4] fpga: bridge: Add dummy definitions of API functions
Date: Wed,  5 Nov 2025 12:31:06 +0000
Message-ID: <20251105123752.93672-3-abbotti@mev.co.uk>
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
X-Classification-ID: 2331ede2-2f65-45fd-b71e-e0d81416256f-3-1

Add dummy versions of the FPGA bridge API functions for build testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct conditional compilation test for FPGA_BRIDGE tristate
    configuration.
---
 include/linux/fpga/fpga-bridge.h | 75 +++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 94c4edd047e5..82494cc325f3 100644
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
+#if IS_ENABLED(CONFIG_FPGA_BRIDGE)
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


