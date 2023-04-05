Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B86D762F
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 10:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjDEICU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbjDEICS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 04:02:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BCB30ED;
        Wed,  5 Apr 2023 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680681734; x=1712217734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hjp80/410tmJHmpO6rGQObwfiLzMo70h6PwRGNv+znI=;
  b=dcDuqcflk8dxNJIB2EeoV4LYYUlEukO25gI5CXxaXwX2hcUoe7CWlOM4
   kV8hcKbyUnX9yGFWnqiQi9BGGA7Io0JkLPfitRVC0cjMfosd5yFNjutBE
   N48wSjSbaeNgvSLLcG6JQoyG1jnZtg6nRo9gBm2kwpOfz6rcEFWIJrXx9
   C7hI5gmErVwU38jN52vlEH+UTYLr/8OWxKuDBi806pr55DsHnzJZrNz6A
   bPFO5/almOaknut/42dvayoxpgtA4Lw0lp2VAix5cbsSZumiKYaiHrfTF
   5/CHXUd5+9ShdxMmb3SMBzinQFkR0WGNayx/Arup9ubK33CS998D4fkwS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428680206"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428680206"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775959618"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="775959618"
Received: from wtedesch-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.53.134])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:01:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] Manage register access to control delay during sec update
Date:   Wed,  5 Apr 2023 11:01:48 +0300
Message-Id: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Manage handshake register access on Max 10 FPGA cards that have a major
slowdown on reading handshake registers during secure update prepare and
write phases. The problem does not occur with PMCI-based cards.

Ilpo Järvinen (4):
  mfd: intel-m10-bmc: Move core symbols to own namespace
  mfd: intel-m10-bmc: Create m10bmc_sys_update_bits()
  mfd: intel-m10-bmc: Move m10bmc_sys_read() away from header
  mfd: intel-m10-bmc: Manage access to MAX 10 fw handshake registers

 drivers/fpga/intel-m10-bmc-sec-update.c | 47 ++++++++------
 drivers/hwmon/intel-m10-bmc-hwmon.c     |  1 +
 drivers/mfd/intel-m10-bmc-core.c        | 84 ++++++++++++++++++++++++-
 drivers/mfd/intel-m10-bmc-pmci.c        |  5 ++
 drivers/mfd/intel-m10-bmc-spi.c         | 15 +++++
 include/linux/mfd/intel-m10-bmc.h       | 42 +++++++++----
 6 files changed, 161 insertions(+), 33 deletions(-)

-- 
2.30.2

