Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2795037AB
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiDPRBT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiDPRBR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 13:01:17 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C84C411;
        Sat, 16 Apr 2022 09:58:44 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 112E5223DA;
        Sat, 16 Apr 2022 16:58:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 42FA32000E;
        Sat, 16 Apr 2022 16:58:41 +0000 (UTC)
Message-ID: <ac22068dad06fd61f2e82c0bf7c0f58a4e5df050.camel@perches.com>
Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
From:   Joe Perches <joe@perches.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Date:   Sat, 16 Apr 2022 09:58:40 -0700
In-Reply-To: <20220416133719.3382895-3-nava.manne@xilinx.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
         <20220416133719.3382895-3-nava.manne@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: 5iasq51u9gsrfia9ayz48s37ztk95x9o
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 42FA32000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18NXzAwtfsG6VD8cMuiMu8V8tvZafI+GT8=
X-HE-Tag: 1650128321-724278
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, 2022-04-16 at 19:07 +0530, Nava kishore Manne wrote:
> fixes the below checks reported by checkpatch.pl
> Lines should not end with a '('
> Alignment should match open parenthesis

in fpga-mgr:
	Another possibillty would be to change the function arguments

and 

in fpga-region:
	Ideally keep the include declaration and definition styles synced

Perhaps:
---
 drivers/fpga/fpga-mgr.c          | 13 ++++++++-----
 drivers/fpga/fpga-region.c       |  6 +++---
 include/linux/fpga/fpga-region.h |  6 +++---
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..c65b97450a67 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -148,12 +148,15 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
-	if (!mgr->mops->initial_header_size)
-		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
-	else
-		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
+	if (mgr->mops->initial_header_size) {
+		count = min(mgr->mops->initial_header_size, count);
+	} else {
+		buf = NULL;
+		count = 0;
+	}
+
+	ret = fpga_mgr_write_init(mgr, info, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b0ac18de4885..485948e3c0db 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -18,9 +18,9 @@
 static DEFINE_IDA(fpga_region_ida);
 static struct class *fpga_region_class;
 
-struct fpga_region *fpga_region_class_find(
-	struct device *start, const void *data,
-	int (*match)(struct device *, const void *))
+struct fpga_region *
+fpga_region_class_find(struct device *start, const void *data,
+		       int (*match)(struct device *, const void *))
 {
 	struct device *dev;
 
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 3b87f232425c..9d4d32909340 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -52,9 +52,9 @@ struct fpga_region {
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
 
-struct fpga_region *fpga_region_class_find(
-	struct device *start, const void *data,
-	int (*match)(struct device *, const void *));
+struct fpga_region *
+fpga_region_class_find(struct device *start, const void *data,
+		       int (*match)(struct device *, const void *));
 
 int fpga_region_program_fpga(struct fpga_region *region);
 

