Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27CC682262
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 03:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAaCwB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Jan 2023 21:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAaCwB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 Jan 2023 21:52:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4230281
        for <linux-fpga@vger.kernel.org>; Mon, 30 Jan 2023 18:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675133520; x=1706669520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rbbao6GLKvskB4Kyet6DxZqCsIicqy9XdEo4NkdeamM=;
  b=N2K0Pxqz9u8/k6W4JSxTnAgRSp1ZUoizoclJt8oJTpWulVzIlB4yQMt4
   SK7UTNICLtNFeY3kMe8RyXp3tG+Jp8eVXQlnfd5mfPdjJe9i5QyraQPXF
   BZTPisjUWX9jXXfj0bKh53ZaMUVX2Q6LQHAiSNdVLV+FUh8zuXYwdLbwm
   rl6GtNTf+9+zLSYjVVF9+vWqj2iyFESb2HdyS7/dtT9BqB/CubeZNxwAT
   O355ezKFDqpl0FRR9TR2ypiyFADJNjjW9uU+A4WUUVbyKlrjiEv834b+U
   9Zro1j0ITxqKYlLxS8m5I7yzMwXfN+RtLCewapSBYJb0zKVQPja/HgSJl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311359092"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="311359092"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 18:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727753025"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="727753025"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2023 18:51:58 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org, lee@kernel.org
Subject: [PATCH 0/1] A missing FPGA patch for v6.3-rc1
Date:   Tue, 31 Jan 2023 10:41:19 +0800
Message-Id: <20230131024121.940195-1-yilun.xu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg:

You've pulled the topic branch ib-mfd-fpga-hwmon-v6.3 when handling

  [GIT PULL] FPGA Manager changes for 6.3-rc1

But the final patch is overlooked in this topic branch, see:

https://lore.kernel.org/all/Y9d9MmttFUqnCyCs@google.com/

So could you help check and merge it, thanks.

Ilpo Järvinen (1):
  fpga: m10bmc-sec: Add support for N6000

 drivers/fpga/intel-m10-bmc-sec-update.c |  51 ++++-
 drivers/mfd/intel-m10-bmc-pmci.c        | 242 +++++++++++++++++++++++-
 include/linux/mfd/intel-m10-bmc.h       |  51 +++++
 3 files changed, 336 insertions(+), 8 deletions(-)

-- 
2.25.1

