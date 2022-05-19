Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5D52DFD8
	for <lists+linux-fpga@lfdr.de>; Fri, 20 May 2022 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245395AbiESWNf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 18:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbiESWNe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 18:13:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62126A5005;
        Thu, 19 May 2022 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652998414; x=1684534414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFmq/RU+MxSprUYx5V19OMcQd3bPLRLL+9B9N2X/Hlg=;
  b=nBlKAKG3wE2sHb+vxREiNIbCO8X6DonPvDOiWQgc3PXTak8l2MWyyvIM
   5QpZXikDZu73Uvv5stWRHfYtByqT9zV/ZxAnwasplJE8yV1sJdMJWyge2
   1s9ZNcVPcC9Ch1CiFB7RwSy4bWY00RCJhDDUE07J0oD4KCZ9IQZJtqpe+
   oBcnSUo3ElXzqTrmKex42RCb14cGJlO0lsQtLRYJZdwSV0xQPlpNbj6Hh
   itcCujMRo26eIt8czR3ivrMZaemrJSk8GWOZPc+FUFWxo3mF1MZIjsZ+B
   3Wa528C2S/eQcfVpcJfxb1Skdf+1VoYEtIlGV6fdQ887g+anasIm4IzcZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272097513"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272097513"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743162376"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:32 -0700
From:   Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        tianfei.zhang@intel.com,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: [PATCH 2/3] fpga: dfl: Fix kernel-doc warnings in include/linux/dfl.h
Date:   Thu, 19 May 2022 15:12:48 -0700
Message-Id: <20220519221249.858873-3-basheer.ahmed.muddebihal@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519221249.858873-1-basheer.ahmed.muddebihal@linux.intel.com>
References: <20220519221249.858873-1-basheer.ahmed.muddebihal@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixed the following warnings:
include/linux/dfl.h:21: warning: Enum value 'FME_ID' not described in enum 'dfl_id_type'
include/linux/dfl.h:21: warning: Enum value 'PORT_ID' not described in enum 'dfl_id_type'
include/linux/dfl.h:21: warning: Enum value 'DFL_ID_MAX' not described in enum 'dfl_id_type'
include/linux/dfl.h:47: warning: Function parameter or member 'revision' not described in 'dfl_device'

Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
 include/linux/dfl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 431636a0dc78..4caa2d99d8dc 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -13,6 +13,9 @@
 
 /**
  * enum dfl_id_type - define the DFL FIU types
+ * @FME_ID: dfl id for FPGA Management Engine node.
+ * @PORT_ID: dfl id for Port.
+ * @DFL_ID_MAX: maximum number for dfl ids.
  */
 enum dfl_id_type {
 	FME_ID = 0,
@@ -27,6 +30,7 @@ enum dfl_id_type {
  * @id: id of the dfl device.
  * @type: type of DFL FIU of the device. See enum dfl_id_type.
  * @feature_id: feature identifier local to its DFL FIU type.
+ * @revision: feature revision local to its DFL FIU type.
  * @mmio_res: mmio resource of this dfl device.
  * @irqs: list of Linux IRQ numbers of this dfl device.
  * @num_irqs: number of IRQs supported by this dfl device.
-- 
2.34.1

