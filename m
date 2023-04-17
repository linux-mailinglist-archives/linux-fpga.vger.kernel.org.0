Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D566E4375
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjDQJQk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjDQJQj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 05:16:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1815849CA;
        Mon, 17 Apr 2023 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681722998; x=1713258998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4KF2KAjyrsD3AOzxtejb2jOCrRVS9sKyae+V2KcLQzw=;
  b=M4JAgf5dnOOY1ZPwGh5bixZn7xrT9C8iz0zNJfuyUH0WePNTzChh+03N
   44o6oMxrLgVEywGY4xnRMe5qxY/c43/hg2RqO43NAdlpFALGojld0DCrC
   9I7dZ/Fdi0pgwg2r3w3++LemBfCMAYWUTuMaqmkln8BpSZtHH9vAKJC4A
   5QPwJ7dl7v3Y6rNFGkUniE6tIuIh020lkwDydRwxN9C8IyOJGdryjTmYK
   RWqh/HqJ2hSSGpnFPpQgvDliSlknNdTM+81c6zL4pCBzcsQGSaz1gP41L
   k0Lr41xCzVqDnEVT9WSFVmE76s4dQr1U378skY4S2lXKxWYklIdyXZsXH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="342338676"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="342338676"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="690595451"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="690595451"
Received: from anicosix-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.35.34])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:16:34 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/4] intel-m10-bmc: Manage register access to control delay during sec update
Date:   Mon, 17 Apr 2023 12:16:15 +0300
Message-Id: <20230417091619.14134-1-ilpo.jarvinen@linux.intel.com>
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

