Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F806E1AE6
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Apr 2023 05:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDNDpL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Apr 2023 23:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDNDow (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 13 Apr 2023 23:44:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092849C7;
        Thu, 13 Apr 2023 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681443891; x=1712979891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=im+rD4DdLuPF1wz2y+TfK5jmNNjayVIPFPfTpu5gAhU=;
  b=PmbOyZALgSaTundQfKgKt0GFpnTYBZkL5849ULe+FiOUdCoTzLwsVQkg
   lm2x5JgDYOxJigOSnfSeOhaHcoZGXuP1valkp9VzXhL3g5HT2XnGEyGTp
   eBqRkqncO94LrOYdghDcOeqo/AxYyE4A6wGYkrfnIuOaxsH47jaZiag3R
   iFB/UHzB8f6Gd3nzqSvjj1RP78iAOMbS9d1FhIC+gWJQVqRlpgN12HOgc
   r+8C27sSC1TyRzHvOVk45l0PIMiZlKshMkZUcD84UNvRIAoQ9tk8MvyoU
   7/HI9df1aMGcktcm+Y75ykMqxuHmQtANVtuYV49dhrEKfW7AArKbHB0P3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="328521106"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="328521106"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 20:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935857419"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="935857419"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 13 Apr 2023 20:44:47 -0700
Date:   Fri, 14 Apr 2023 11:45:26 +0000
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
Message-ID: <ZDk81v7DuSVh6228@yilunxu-OptiPlex-7050>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
 <20230405080152.6732-5-ilpo.jarvinen@linux.intel.com>
 <ZC+1rKoUNsqrjjtw@yilunxu-OptiPlex-7050>
 <fb95c8da-c828-12b8-aae-56bd867cff41@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb95c8da-c828-12b8-aae-56bd867cff41@linux.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-11 at 14:54:58 +0300, Ilpo Järvinen wrote:
> On Fri, 7 Apr 2023, Xu Yilun wrote:
> 
> > On 2023-04-05 at 11:01:52 +0300, Ilpo Järvinen wrote:
> > > On some MAX 10 cards, the BMC firmware is not available to service
> > > handshake registers during secure update erase and write phases at
> > > normal speeds. This problem affects at least hwmon driver. When the MAX
> > > 10 hwmon driver tries to read the sensor values during a secure update,
> > > the reads are slowed down (e.g., reading all D5005 sensors takes ~24s
> > > which is magnitudes worse than the normal <0.02s).
> > > 
> > > Manage access to the handshake registers using a rw semaphore and a FW
> > > state variable to prevent accesses during those secure update phases
> > > and return -EBUSY instead.
> > > 
> > > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
> > >  drivers/mfd/intel-m10-bmc-core.c        | 63 ++++++++++++++++++++++++-
> > >  drivers/mfd/intel-m10-bmc-pmci.c        |  4 ++
> > >  drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
> > >  include/linux/mfd/intel-m10-bmc.h       | 27 +++++++++++
> > >  5 files changed, 120 insertions(+), 5 deletions(-)
> > >
> > 
> > [...]
> >  
> > >  
> > > +void m10bmc_fw_state_set(struct intel_m10bmc *m10bmc, enum m10bmc_fw_state new_state)
> > > +{
> > > +	down_write(&m10bmc->bmcfw_lock);
> > > +	m10bmc->bmcfw_state = new_state;
> > > +	up_write(&m10bmc->bmcfw_lock);
> > 
> > Could we also skip this if no handshake is possible like for PMCI?
> 
> Did you mean guarding it with !m10bmc->info->handshake_sys_reg_nranges ?

Yes. My concern is, the handshake_sys_reg_nranges is the constant value
for a device, so if the device doesn't have handshake registers, we
could save the locking costs.

Thanks,
Yilun

> If yes, it's doable (+ I'd add comment mentioning it since it's slightly 
> trappy to not always have that state updated).
> 
> 
> -- 
>  i.

