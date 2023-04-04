Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1176A6D630F
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjDDNeg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjDDNeY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:34:24 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478649CE;
        Tue,  4 Apr 2023 06:33:59 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6B34AE000B;
        Tue,  4 Apr 2023 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680615238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mo3HjqG41gQvCICstu9RcQV968d5yyBtvPhjoFmW600=;
        b=GxlHdy4eBR/YbPceBaocXsvSxmEp3u/fxMIh5Dfb7A4Bd5lliBXi5bYo8oWgLeEEAY1IR6
        1g/7+TL7i91+ve8ld8/wrQ8JExZ21LTjjzHhshte3ZXRryQqRpVJnNnjdCti5JiE/4HO7z
        aYCg7r9U0lFDOkcJ1azl8GuYvArkws8O682QhF2tqfvD5LB4ZSnYpZfUnRQ59Adeqk6qs+
        4g8K6YtgbypzAVxcGf/MZTx1DR4XC+CrrGkpB+M8Di1DavMH5M1SmpzeGyqDYH4fXP47ca
        u5D7zA7OEkzMdid0Ys2itN2N6XDwcxl9xPhOUfnw+uWSIqN8qXZdSliDFq+Bcw==
From:   alexis.lothore@bootlin.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com, nicolas.carrier@orolia.com
Subject: [PATCH] fpga: bridge: properly initialize bridge device before populating children
Date:   Tue,  4 Apr 2023 15:31:02 +0200
Message-Id: <20230404133102.2837535-2-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404133102.2837535-1-alexis.lothore@bootlin.com>
References: <20230404133102.2837535-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

The current code path can lead to warnings because of uninitialized device,
which contains, as a consequence, uninitialized kobject. The uninitialized
device is passed to of_platform_populate, which will at some point, while
creating child device, try to get a reference on uninitialized parent,
resulting in the following warning:

kobject: '(null)' ((ptrval)): is not initialized, yet kobject_get() is
being called.

The warning is observed after migrating a kernel 5.10.x to 6.1.x.
Reverting commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for
class driver") seems to remove the warning.
This commit aggregates device_initialize() and device_add() into
device_register() but this new call is done AFTER of_platform_populate

Fixes: 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class driver")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/fpga/fpga-bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 727704431f61..13918c8c839e 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -360,7 +360,6 @@ fpga_bridge_register(struct device *parent, const char *name,
 	bridge->dev.parent = parent;
 	bridge->dev.of_node = parent->of_node;
 	bridge->dev.id = id;
-	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);
 
 	ret = dev_set_name(&bridge->dev, "br%d", id);
 	if (ret)
@@ -372,6 +371,8 @@ fpga_bridge_register(struct device *parent, const char *name,
 		return ERR_PTR(ret);
 	}
 
+	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);
+
 	return bridge;
 
 error_device:
-- 
2.40.0

