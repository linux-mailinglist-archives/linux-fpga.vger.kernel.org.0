Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81FB67E8EB
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjA0PF5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 10:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjA0PFx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 10:05:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B17C332;
        Fri, 27 Jan 2023 07:05:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4080861C39;
        Fri, 27 Jan 2023 15:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3B5C433A4;
        Fri, 27 Jan 2023 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674831950;
        bh=FtvO0kXKZ+yj6zFsJ9gzywOH3VKXkQ8R4l+2Ia2BBnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8D/mt4hXZ4feL7L06HfrAnqQyKXmgc+jccuP6XvPLmhqcFQHl+P87jqkDy19Wh7l
         qqvXN25C5T0ejU64MdlsHtcFYBdLVy+vaoJiVI/XpCuwzU91PqINDyDaoRZVE7b0RV
         HG3SKLBhNyME5KJ6xbq98kLS5dmlXw5UMbXeo+wD/ORHCL0URP150tGLBGTp8PBVrE
         gubYB2HO0LOS7IKavVgUTU5n6oX2A3APobpwKU+RhmG4vdOzNYvfmQmtiDZjPFMDNr
         gNmezc1yZEmCxwD+9Ui8bK2OQ4R7MyzRRTnIJi2bjRU++tjWHXrhq7r5U4HzWUAWwL
         qud3LAnHJOP+Q==
Date:   Fri, 27 Jan 2023 15:05:44 +0000
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
Subject: Re: [PATCH v6 00/11] intel-m10-bmc: Split BMC to core and SPI parts
 & add PMCI+N6000 support
Message-ID: <Y9PoSHUgLtBvZQXk@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <Y9PnChtJnIGhu4wt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9PnChtJnIGhu4wt@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ignore this - I forgot to sign it!

On Fri, 27 Jan 2023, Lee Jones wrote:

> Enjoy!
> 
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-fpga-hwmon-6.3
> 
> for you to fetch changes up to 869b9eddf0b38a22c27a400e2fa849d2ff2aa7e1:
> 
>   mfd: intel-m10-bmc: Add PMCI driver (2023-01-27 10:47:11 +0000)
> 
> ----------------------------------------------------------------
> Ilpo Järvinen (10):
>       mfd: intel-m10-bmc: Add missing includes to header
>       mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
>       mfd: intel-m10-bmc: Rename the local variables
>       mfd: intel-m10-bmc: Split into core and spi specific parts
>       mfd: intel-m10-bmc: Support multiple CSR register layouts
>       fpga: intel-m10-bmc: Rework flash read/write
>       mfd: intel-m10-bmc: Prefix register defines with M10BMC_N3000
>       fpga: m10bmc-sec: Create helpers for rsu status/progress checks
>       fpga: m10bmc-sec: Make rsu status type specific
>       mfd: intel-m10-bmc: Add PMCI driver
> 
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |   8 +-
>  MAINTAINERS                                        |   2 +-
>  drivers/fpga/Kconfig                               |   2 +-
>  drivers/fpga/intel-m10-bmc-sec-update.c            | 364 +++++++++++++--------
>  drivers/hwmon/Kconfig                              |   2 +-
>  drivers/mfd/Kconfig                                |  32 +-
>  drivers/mfd/Makefile                               |   5 +-
>  drivers/mfd/intel-m10-bmc-core.c                   | 122 +++++++
>  drivers/mfd/intel-m10-bmc-pmci.c                   | 219 +++++++++++++
>  drivers/mfd/intel-m10-bmc-spi.c                    | 168 ++++++++++
>  drivers/mfd/intel-m10-bmc.c                        | 238 --------------
>  include/linux/mfd/intel-m10-bmc.h                  | 154 ++++++---
>  12 files changed, 888 insertions(+), 428 deletions(-)
>  create mode 100644 drivers/mfd/intel-m10-bmc-core.c
>  create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
>  create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
>  delete mode 100644 drivers/mfd/intel-m10-bmc.c
> 
> -- 
> Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]
