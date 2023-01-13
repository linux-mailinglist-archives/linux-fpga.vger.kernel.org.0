Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D19668E6C
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jan 2023 07:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjAMGyE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Jan 2023 01:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjAMGxU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 13 Jan 2023 01:53:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE4C6E422;
        Thu, 12 Jan 2023 22:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F5GSfMcXneCJHWOdElTSTtKlD1fdAJ9ZKc/uf3kJ2U0=; b=Rcq6BWKelXzW/gjRwWGvJiKe3/
        nk7pF5XP3mRfF2qA70EXLrh37c+Ve+qgIFpRdUaOdnRf6mf/32AmbVy63cM+3ANAGeCYqzUHNyjkP
        8wJ7+zWbACrahilCRSfcIrl+vfpF/BFldbDomUef3Grd5bpzl9MTG+DxPUIliiIFNjO7xxFuj/pT3
        mCLHmFsgzZ8wSfp6tRsppunpzRX2OkMryBG4bw2lqSq+TjUqhWkmrqS2QSf6LpJC/NpAsKhwRCgxP
        xQm3o2WbEo3R7nvUemH8vNqduIuShQ02J96KMbivzzdy4wymB7YSkmgbVZ7UhUE0E7NrGW7KlDz/h
        1N8h7rXw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDgo-000qE9-8F; Fri, 13 Jan 2023 06:37:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: dfl: kernel-doc corrections
Date:   Thu, 12 Jan 2023 22:37:20 -0800
Message-Id: <20230113063720.10668-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix W=1 kernel-doc warnings in drivers/fpga/:

drivers/fpga/dfl.c:54: warning: cannot understand function prototype: 'struct dfl_dev_info '
drivers/fpga/dfl.c:74: warning: cannot understand function prototype: 'struct dfl_chardev_info '
drivers/fpga/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'
drivers/fpga/dfl-fme-pr.c:280: warning: expecting prototype for dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: linux-fpga@vger.kernel.org
---
 drivers/fpga/dfl-fme-pr.c |    4 ++--
 drivers/fpga/dfl.c        |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff -- a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -45,7 +45,7 @@ static const char *dfl_pdata_key_strings
 };
 
 /**
- * dfl_dev_info - dfl feature device information.
+ * struct dfl_dev_info - dfl feature device information.
  * @name: name string of the feature platform device.
  * @dfh_id: id value in Device Feature Header (DFH) register by DFL spec.
  * @id: idr id of the feature dev.
@@ -67,7 +67,7 @@ static struct dfl_dev_info dfl_devs[] =
 };
 
 /**
- * dfl_chardev_info - chardev information of dfl feature device
+ * struct dfl_chardev_info - chardev information of dfl feature device
  * @name: nmae string of the char device.
  * @devt: devt of the char device.
  */
@@ -708,6 +708,7 @@ struct build_feature_devs_info {
  * struct dfl_feature_info - sub feature info collected during feature dev build
  *
  * @fid: id of this sub feature.
+ * @revision: revision value of this sub feature.
  * @mmio_res: mmio resource of this sub feature.
  * @ioaddr: mapped base address of mmio resource.
  * @node: node in sub_features linked list.
diff -- a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -164,7 +164,7 @@ free_exit:
 
 /**
  * dfl_fme_create_mgr - create fpga mgr platform device as child device
- *
+ * @feature: sub feature info
  * @pdata: fme platform_device's pdata
  *
  * Return: mgr platform device if successful, and error code otherwise.
@@ -273,7 +273,7 @@ static void dfl_fme_destroy_bridge(struc
 }
 
 /**
- * dfl_fme_destroy_bridge - destroy all fpga bridge platform device
+ * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
  * @pdata: fme platform device's pdata
  */
 static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
