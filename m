Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A38F67EC96
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 18:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjA0RfC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 12:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjA0RfC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 12:35:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03C1114B;
        Fri, 27 Jan 2023 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674840899; x=1706376899;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=6CZvLjtA6nkJFaj5XpJOO6EgdpKBDhRI/YtMBEJuKLw=;
  b=gO2GXDr/Q4bxrsSa6V39uv6G1Rn2+WCUHquyiYjrKBPgezW6kpq2cI6E
   SWKQALzdt0GwUXEDj/ydKNuuCZk6fcwIz1wIbAeRxZ6sLEzVka74AT9E5
   NsJEMJU3h6/rF3vDVdWXLVkjIvcuRFKqDvw6H6Z0dfkxYH0D5Wd3wmUco
   mrogz+SNjsbOubMNNnOBzn9WDfhAwTztfsf2aShsk7hbYBWcKHaLB3/up
   vVhwVnypU0wg6OKsAm7aHEHANtcDeQAIBWaQ5+q7IcJbMP1Ow3H4UdrYH
   N5HF9ZgSMZqeSDN0KAvttfBKpljgaE4weuJOf9vHGFEMbMc8IVuwz+EMz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327161555"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="327161555"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:34:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="731930153"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="731930153"
Received: from maseidel-mobl1.ger.corp.intel.com (HELO varistar-mobl2.ger.corp.intel.com) ([10.252.57.131])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:34:56 -0800
Date:   Fri, 27 Jan 2023 19:34:54 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/11] intel-m10-bmc: Split BMC to core and SPI parts
 & add PMCI+N6000 support
In-Reply-To: <Y9PnChtJnIGhu4wt@google.com>
Message-ID: <916b3bb1-2f99-aa39-9159-c4c2b92855c3@linux.intel.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com> <Y9PnChtJnIGhu4wt@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-674294556-1674840401=:1778"
Content-ID: <48e2dbe-1a39-9f86-7451-b5dfbee9e54@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-674294556-1674840401=:1778
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b260eda-b5d1-8f39-a4ab-fad1f915ba41@linux.intel.com>

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

Hi Lee,

Thanks. I was left to wonder is there some particular reason for why 11/11 
was not taken among the others? Did I perhaps end up giving a wrong 
impression in the cover letter that it wouldn't have been complete yet?

-- 
 i.
--8323329-674294556-1674840401=:1778--
