Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AB68074D
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Jan 2023 09:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjA3ISH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Jan 2023 03:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjA3ISF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 Jan 2023 03:18:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A994113EE;
        Mon, 30 Jan 2023 00:18:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F0AFCE1292;
        Mon, 30 Jan 2023 08:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7071AC433EF;
        Mon, 30 Jan 2023 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675066679;
        bh=yvrOVAzB/NQoOLMVjcLN3P+EXkqTYh76YyNByM4PI2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRoaTDY0CPwJB2Ah9tQN7F0v8ElGTprmDtVCkGtneQvhbkqqJLujwZ+wRU4qf5i8o
         TH8siPXiLhXAMUqUWb0Rrfj54nWjFYjX619BpVF97HIG43h8d6/C+aUkJD+as2PQoS
         W78UyruChUt4423lYf9VmVHSjdZSOv1RgYxSv6XzVrl93CcnsX6XzefgHKkFaIPOVO
         lKHRBaSyEt14d4ulDLf71mCJ/0sJaG6G9UUh1tv/z9PMMdCF+9un1QWGW7FD7MIXlp
         bQcNsZaFbPh3ng5UKTNe3qGv7YckTAyVCKI0ssBYoHAjoWE6VnijqAgNs97eD8Ktnw
         o4QPfnysXFoZA==
Date:   Mon, 30 Jan 2023 08:17:54 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] Immutable branch between MFD, FPGA and HWMON due for
 the v6.3 merge window
Message-ID: <Y9d9MmttFUqnCyCs@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

New PR containing the final (11/11) patch.

Apologies for the oversight.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-fpga-hwmon-v6.3-1

for you to fetch changes up to acf63c458b55ecfb2015b33dd6ba3cc8fbc1c5d3:

  fpga: m10bmc-sec: Add support for N6000 (2023-01-30 08:14:02 +0000)

----------------------------------------------------------------
Immutable branch between MFD, FPGA and HWMON due for the v6.3 merge window

----------------------------------------------------------------
Ilpo Järvinen (11):
      mfd: intel-m10-bmc: Add missing includes to header
      mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
      mfd: intel-m10-bmc: Rename the local variables
      mfd: intel-m10-bmc: Split into core and spi specific parts
      mfd: intel-m10-bmc: Support multiple CSR register layouts
      fpga: intel-m10-bmc: Rework flash read/write
      mfd: intel-m10-bmc: Prefix register defines with M10BMC_N3000
      fpga: m10bmc-sec: Create helpers for rsu status/progress checks
      fpga: m10bmc-sec: Make rsu status type specific
      mfd: intel-m10-bmc: Add PMCI driver
      fpga: m10bmc-sec: Add support for N6000

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |   8 +-
 MAINTAINERS                                        |   2 +-
 drivers/fpga/Kconfig                               |   2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            | 415 ++++++++++++-------
 drivers/hwmon/Kconfig                              |   2 +-
 drivers/mfd/Kconfig                                |  32 +-
 drivers/mfd/Makefile                               |   5 +-
 drivers/mfd/intel-m10-bmc-core.c                   | 122 ++++++
 drivers/mfd/intel-m10-bmc-pmci.c                   | 455 +++++++++++++++++++++
 drivers/mfd/intel-m10-bmc-spi.c                    | 168 ++++++++
 drivers/mfd/intel-m10-bmc.c                        | 238 -----------
 include/linux/mfd/intel-m10-bmc.h                  | 205 ++++++++--
 12 files changed, 1221 insertions(+), 433 deletions(-)
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c

-- 
Lee Jones [李琼斯]
