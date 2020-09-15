Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34624269C98
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIODcw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:32:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:64033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgIODci (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 23:32:38 -0400
IronPort-SDR: qoBifkpCd00ua3pOnu4gwZqX7MGccjXZZN+2bgB2a8jbLAwPO3ZuLOnehXAo9dBVi3zHHb8EB9
 SUkvN6326TNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="244026455"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="244026455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 20:32:37 -0700
IronPort-SDR: JWajAGiUSfOXtLD5k0IW0CxCtulIWZ//bqKc9e8R9HqMK9JefVT/ig6ZhK8VpN2C9GNJV+A9ui
 hQ5X7u8+jZpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="482596431"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2020 20:32:36 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 3/4] fpga: dfl: fix the comments of type & feature_id fields
Date:   Tue, 15 Sep 2020 11:27:52 +0800
Message-Id: <1600140473-12351-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The description of feature_id in struct dfl_device is not accurate. In
DFL specification the feature_id is the 12 bits field. The description
in struct dfl_device_id is more clear so we make them aligned. We also
made the similar fix for the type field.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 3c69596..d5e050a 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -531,8 +531,8 @@ enum dfl_id_type {
  *
  * @dev: generic device interface.
  * @id: id of the dfl device.
- * @type: type of DFL FIU of the device. See enum dfl_id_type.
- * @feature_id: 16 bits feature identifier local to its DFL FIU type.
+ * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
+ * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
  * @mmio_res: mmio resource of this dfl device.
  * @irqs: list of Linux IRQ numbers of this dfl device.
  * @num_irqs: number of IRQs supported by this dfl device.
-- 
2.7.4

