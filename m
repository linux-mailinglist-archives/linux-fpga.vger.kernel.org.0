Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21FD6DDA0A
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Apr 2023 13:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjDKLry (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Apr 2023 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjDKLrv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Apr 2023 07:47:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B211A;
        Tue, 11 Apr 2023 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213655; x=1712749655;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CFMnqxFhqLg5psuQ3SAPZVSG1LD94Tg/B/5LrnIudj0=;
  b=nzp9OnjEhNHhR8XHnkoyPHCB3SSg9ytxhFqnVhHYuk1413X4p5+ujhkA
   B0Qe9JQ9PDA0eUBqRCSYnBr4+rFXLMkQfIUr2jLf47ZNlhMvJs2itX0Fr
   2YJOkL69nMVKeUAI6nL+S2hjUloe9zIr0QqlTJ3qF2tb8mQxltE4zI56/
   MuISSr/Yz2vgRdFivXruTyYzrb53daQoy9enDPvTyyD7tRnmAZtyCZipw
   kl7Et+35rWrSflw9TpeUwAeumtY9h9fW1/M34FibvRV7wPlUJfd871K8s
   i/7ILRf+Ef2IRYHdLxtMCeGvNvOT5zaOv5hcDD9+3L1e+XEgy+Tz+8H1l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="371444477"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="371444477"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018343670"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018343670"
Received: from rwambsga-mobl.ger.corp.intel.com ([10.251.212.142])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:45:07 -0700
Date:   Tue, 11 Apr 2023 14:45:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
In-Reply-To: <ZC+z16LvAxxyRSg/@yilunxu-OptiPlex-7050>
Message-ID: <6037f0e2-9c9d-b3d8-2641-bb362a2cec2e@linux.intel.com>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com> <20230405080152.6732-5-ilpo.jarvinen@linux.intel.com> <ZC+z16LvAxxyRSg/@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-137825018-1681213517=:2109"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-137825018-1681213517=:2109
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 7 Apr 2023, Xu Yilun wrote:

> On 2023-04-05 at 11:01:52 +0300, Ilpo Järvinen wrote:
> > On some MAX 10 cards, the BMC firmware is not available to service
> > handshake registers during secure update erase and write phases at
> > normal speeds. This problem affects at least hwmon driver. When the MAX
> > 10 hwmon driver tries to read the sensor values during a secure update,
> > the reads are slowed down (e.g., reading all D5005 sensors takes ~24s
> > which is magnitudes worse than the normal <0.02s).
> > 
> > Manage access to the handshake registers using a rw semaphore and a FW
> > state variable to prevent accesses during those secure update phases
> > and return -EBUSY instead.
> > 
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
> >  drivers/mfd/intel-m10-bmc-core.c        | 63 ++++++++++++++++++++++++-
> >  drivers/mfd/intel-m10-bmc-pmci.c        |  4 ++
> >  drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
> >  include/linux/mfd/intel-m10-bmc.h       | 27 +++++++++++
> >  5 files changed, 120 insertions(+), 5 deletions(-)
> >
> 
> [...]
>  
> >  
> > +static const struct regmap_range null_fw_handshake_regs[0];
> > +
> >  static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
> >  	.base = M10BMC_N6000_SYS_BASE,
> >  	.build_version = M10BMC_N6000_BUILD_VER,
> > @@ -375,6 +377,8 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
> >  static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
> >  	.cells = m10bmc_pmci_n6000_bmc_subdevs,
> >  	.n_cells = ARRAY_SIZE(m10bmc_pmci_n6000_bmc_subdevs),
> > +	.handshake_sys_reg_ranges = null_fw_handshake_regs,
> > +	.handshake_sys_reg_nranges = 0,
> 
> Not sure why a zero length array is needed? Could we just remove
> these 2 lines?

It seems to be safe to remove them so I dropped it.

-- 
 i.

--8323329-137825018-1681213517=:2109--
