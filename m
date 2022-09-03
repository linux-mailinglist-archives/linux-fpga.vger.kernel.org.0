Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C65AC002
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Sep 2022 19:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiICRXE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 3 Sep 2022 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiICRXD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 3 Sep 2022 13:23:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29138564E2;
        Sat,  3 Sep 2022 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662225783; x=1693761783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E7SV1tvE14Rrta1eoerSvxDnugKpcVZ31cMcGlREDBs=;
  b=ajUkTe+MiIF6zES0tsCMZ2MbS9DaEgWkDE1b0uYb9GJ9MCTQ2kHFGl5A
   +/HQQmVCAMlS22zxas1aHx6srTbX2Mg3aUkDAiiObN5tQrPa/Rz5+cYx8
   UFaTmjh6gx2CSho3Td/Zzpu8tC3BuV3dj+F2jJZxUJvQZmOPnzun1fPR/
   3AzTxo80aKLa6mIcK/mLAo1X8UWAlP4CZ9nBdTqlJCKsaAmOhT5PEGwu4
   sH3RLuohrs1NG6GLCBBNniOyfnSgLJr2Zk/8wIgaZtgJ5PfGiGHQmJV5A
   bwTkb5AbpKYXYI4oHbNSET/AK4iDJIZAYrEoNE4NFjsb7XZrB6CEu4Wbo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="293762106"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="293762106"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 10:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="590428747"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2022 10:22:57 -0700
Date:   Sun, 4 Sep 2022 01:13:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH 1/4] firmware: xilinx: Add afi ioctl support
Message-ID: <YxOLPrwwvMWatObc@yilunxu-OptiPlex-7050>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-2-nava.kishore.manne@amd.com>
 <Ywm39iYGLliU9ncv@yilunxu-OptiPlex-7050>
 <DM6PR12MB3993321B918B2124B6776320CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993321B918B2124B6776320CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-30 at 09:25:47 +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Please find my response inline. 
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Saturday, August 27, 2022 11:52 AM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com;
> > mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> > p.zabel@pengutronix.de; gregkh@linuxfoundation.org;
> > ronak.jain@xilinx.com; rajan.vaja@xilinx.com;
> > abhyuday.godhasara@xilinx.com; piyush.mehta@xilinx.com;
> > lakshmi.sai.krishna.potthuri@xilinx.com; harsha.harsha@xilinx.com;
> > linus.walleij@linaro.org; nava.manne@xilinx.com;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-fpga@vger.kernel.org; yilun.xu@intel.com
> > Subject: Re: [PATCH 1/4] firmware: xilinx: Add afi ioctl support
> > 
> > On 2022-08-24 at 09:25:39 +0530, Nava kishore Manne wrote:
> > > Adds afi ioctl to support dynamic PS-PL bus width settings.
> > 
> > Please also describe what is afi, PS, PL here, Patch #0 won't appear in
> > upstream tree finally.
> > 
> 
> Agree, Will update the description in v2.
> 
> > Thanks,
> > Yilun
> > 
> > >
> > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > ---
> > >  drivers/firmware/xilinx/zynqmp.c     | 14 +++++++++++
> > >  include/linux/firmware/xlnx-zynqmp.h | 36
> > > ++++++++++++++++++++++++++++
> > >  2 files changed, 50 insertions(+)
> > >
> > > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > > b/drivers/firmware/xilinx/zynqmp.c
> > > index d1f652802181..cbd84c96a66a 100644
> > > --- a/drivers/firmware/xilinx/zynqmp.c
> > > +++ b/drivers/firmware/xilinx/zynqmp.c
> > > @@ -843,6 +843,20 @@ int zynqmp_pm_read_pggs(u32 index, u32
> > *value)  }
> > > EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
> > >
> > > +/**
> > > + * zynqmp_pm_afi() - PM API for setting the PS-PL bus width
> > > + * @config_id:	Register index value
> > > + * @bus_width:	Afi interface bus width value.
> > > + *
> > > + * Return:	Returns status, either success or error+reason
> > 
> > I see other functions are also like this, but I still can't figure out what values
> > for success and what for error+reason.
> > 
> 
> Please find the relevant error info here:
> https://elixir.bootlin.com/linux/v6.0-rc3/source/drivers/firmware/xilinx/zynqmp.c#L81

The caller should at least know what value is success and what are
failures from the kernel doc, so they could write the code which call
your API.

Thanks,
Yilun

> 
> Regards,
> Navakishore.
> 
