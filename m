Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1575BDCE7
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Sep 2022 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiITGHw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Sep 2022 02:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiITGHv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Sep 2022 02:07:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418FBD6
        for <linux-fpga@vger.kernel.org>; Mon, 19 Sep 2022 23:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663654071; x=1695190071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0N2e7B6Wm5UNMAFYXfr2kOAjzdnWb1/1dMGYtSieRWo=;
  b=R0RlKQ198kEyPaKlI7DH7yK8wAbmo1ckucfX64C5xQaE2kYYMZd1lREI
   H7He1xCPN2mKBYP1KMCj7oJfHrb8HDRCsWP9ugiTFnVzd5kQxpDj63ZF7
   jdeq9LGp0vGC7rywuNw996fsCGXLc/hYYuNUvAzyGMTdsFL5S+a7B/AH8
   BnwmFaG+q3Z7ls2OeLj4oXF8EwBByrMVaBfWmzil6DQn6dk+2HvNnRuNv
   NP3OyWkiyL9hV8UFzgf0VIyXnoCJjpNMLSxrp1yjPgl2SSDQmV/TEQTto
   uAXS3ucsh1+tqLT0WMZx9nrZg60dc8sUQfYhBvF3GTPx5BwbHLWfZXSZS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286654757"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="286654757"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="681159875"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 19 Sep 2022 23:07:49 -0700
Date:   Tue, 20 Sep 2022 13:58:08 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.0-final
Message-ID: <YylWcADWoTtofAmm@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.0-final

for you to fetch changes up to 468c9d928a8f38fdfaa61b05e81473cc7c8a6461:

  fpga: m10bmc-sec: Fix possible memory leak of flash_buf (2022-09-19 12:58:19 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.0-final

Intel m10 bmc secure update

- Russ's change fixes the memory leak for a sysfs node reading

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-6.0 branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Russ Weight (1):
      fpga: m10bmc-sec: Fix possible memory leak of flash_buf

 drivers/fpga/intel-m10-bmc-sec-update.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
