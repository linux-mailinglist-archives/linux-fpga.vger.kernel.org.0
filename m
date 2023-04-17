Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26C6E43DB
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjDQJ1H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjDQJ1F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 05:27:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB4240F3;
        Mon, 17 Apr 2023 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681723624; x=1713259624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hz7VVJKy0PPyHK/swmeOkdzsl1EzXD72HvFBVxr0khE=;
  b=DY0PWfdb6B6D9eNSHV6QOpPHb2wy+GPKfczpDtYgbPlFaAbzrc66H3MQ
   byNfSl36pr0PyPBkfAeEiBI2QK0tGjV2fCaEn9kSMiOKqj+DMHdL5T/of
   pAwhTj0iYsf2naidERTg3OiR5V1JcrHKwXRv37An08rIyXnt9D9n4Hqnr
   ZGDmkMLZ6BHZzWjCeEcUDNPVOT/vzmNxhbyO/qoVV+gG+R2OdU3VRP3DF
   k+ezd7eAaPTE2w1lkqmFL75g8uXOUovAXvLFmQ6aLsN24iVqxbv7IZ5Ko
   3gyA7fRcnXsuzKSDrz+/REsfXatKKSdbw54AO6ThAZ58Fo9ae29F4gEGi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="344846469"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="344846469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="684094766"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="684094766"
Received: from anicosix-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.35.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:27:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/4] intel-m10-bmc: Manage register access to control delay during sec update
Date:   Mon, 17 Apr 2023 12:26:49 +0300
Message-Id: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Manage handshake register access on Max 10 FPGA cards that have a major
slowdown on reading handshake registers during secure update prepare and
write phases. The problem does not occur with PMCI-based cards.

The first patch which moves Max M10 symbols into own namespace is
otherwise independent of the other changes but it would conflict with
this series if sent as separate change. Thus, it's part of this series
to give the patches a well-defined order.

v3:
- Add tags properly & include series version history

v2:
- Add also m10bmc_dev_init() to SYMBOL NS
- Keep bmcfw_state only when handshake_sys_reg_nranges > 0
- Drop zero initializations for handshake_sys_reg*

Ilpo Järvinen (4):
  mfd: intel-m10-bmc: Move core symbols to own namespace
  mfd: intel-m10-bmc: Create m10bmc_sys_update_bits()
  mfd: intel-m10-bmc: Move m10bmc_sys_read() away from header
  mfd: intel-m10-bmc: Manage access to MAX 10 fw handshake registers

 drivers/fpga/intel-m10-bmc-sec-update.c | 47 +++++++------
 drivers/hwmon/intel-m10-bmc-hwmon.c     |  1 +
 drivers/mfd/intel-m10-bmc-core.c        | 90 ++++++++++++++++++++++++-
 drivers/mfd/intel-m10-bmc-pmci.c        |  1 +
 drivers/mfd/intel-m10-bmc-spi.c         | 15 +++++
 include/linux/mfd/intel-m10-bmc.h       | 43 ++++++++----
 6 files changed, 163 insertions(+), 34 deletions(-)

-- 
2.30.2

