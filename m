Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02257C4ED
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jul 2022 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiGUHDl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jul 2022 03:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiGUHDi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Jul 2022 03:03:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B17B1DB;
        Thu, 21 Jul 2022 00:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658387015; x=1689923015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVVixsePGuWthpIXG239h4qnAJPBy+VTisKlJiPtTCs=;
  b=BjbPGqedKfn12AmVmUxPTBQJ1FO3uIBRtxQlIPUfIgd3iS/6AB5iAgzD
   +1OzIzzKtG5ag9fAa0Msi+q4XZryv+/V8NHig/DeEqHOmitEZ8iGqCzov
   VoYrcJqJpmLN6z5XAJp1n1i0w3F22neyF0eAG56e8JZWCE0BxWYLIT3ai
   9LREwuDRXUvUzJJeiaZOH3+2CTq4n8t78GcmAg68QoJBZ/rYdy28qdEOa
   9vqLCsB95DB+/dt/iAMdKb813UimdOmlwGjqmoChBLODbQC0XqEU4XeI9
   0+VtSbrI3Ml6vNMUny+WiWgQ9KCIwhDiv7mY8xnrwMVG6wH2YOF1GSsB5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273815972"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="273815972"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 00:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="573621422"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 00:03:32 -0700
Date:   Thu, 21 Jul 2022 14:54:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git@xilinx.com" <git@xilinx.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
  property
Message-ID: <20220721065454.GA1689481@yilunxu-OptiPlex-7050>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-3-nava.manne@xilinx.com>
 <20220624162815.GA2142910@yilunxu-OptiPlex-7050>
 <DM6PR12MB39937A19AE147CD9105C8D52CD8C9@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB39937A19AE147CD9105C8D52CD8C9@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 18, 2022 at 06:46:32AM +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Friday, June 24, 2022 9:58 PM
> > To: Nava kishore Manne <nava.manne@xilinx.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > michal.simek@xilinx.com; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; git@xilinx.com; Rob Herring <robh@kernel.org>
> > Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
> > property
> > 
> > CAUTION: This message has originated from an External Source. Please use
> > proper judgment and caution when opening attachments, clicking links, or
> > responding to this email.
> > 
> > 
> > On Mon, May 23, 2022 at 07:15:16PM +0530, Nava kishore Manne wrote:
> > > Add fpga-region 'power-domains' property to allow to handle the
> > > FPGA/PL power domains.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changes for v2:
> > >               - Updated power-domains description.
> > >
> > >  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > index 7d3515264838..f299c3749505 100644
> > > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > @@ -196,6 +196,20 @@ Optional properties:
> > >  - config-complete-timeout-us : The maximum time in microseconds time
> > for the
> > >       FPGA to go to operating mode after the region has been programmed.
> > >  - child nodes : devices in the FPGA after programming.
> > > +- power-domains : A phandle and power domain specifier pair to the
> > power domain
> > > +     which is responsible for turning on/off the power to the FPGA/PL
> > region.
> > 
> > Could you help explain what is PL?
> > 
> > > +Example:
> > > +     fpga_full: fpga-full {
> > > +                compatible = "fpga-region";
> > > +                fpga-mgr = <&zynqmp_pcap>;
> > > +                #address-cells = <2>;
> > > +                #size-cells = <2>;
> > > +                ranges;
> > > +                power-domains = <&zynqmp_firmware PL_PD>;
> > > +        };
> > > +
> > > +     The PL_PD power domain will be turned on before loading the
> > > +bitstream and turned off while removing/unloading the bitstream using
> > overlays.
> > 
> > I think the single power-domain may not cover some use cases that of-fpga-
> > region driver supports.
> 
> I am not sure which use case you are talking about. Can you please point me the exact use case here?
>   
> > It is possible there are already devices in fpga-region
> > for static OF tree, or an overlay with no 'firmware-name' but 'external-fpga-
> > config'. In these cases power domains may still be needed, is it?
> >
> 
> It's an optional property user can decide whether he needs this support or not for 'external-fpga-config
> Use case. 

If an external-fpga-config FPGA region needs to enable a power domain before
sub devices population, how could it config the DT? I assume in this
patch "power-domains" property is only used before & after
reconfiguration but external-fpga-config FPGA region may need no
reconfiguration.

> 
> > Another case is the fpga-region may need multiple power domains?
> >
> 
> In our use case full region and relevant partial regions have different power domains and
> this patch is capable of handle different power domain regions (full and partial regions)

If a FPGA region needs 2 or more power domains for partial reconfiguration,
how could we find out and enable them all?

From the 2 cases, I see as a generic driver, there may be need to enable
different power domains at different moments. And I'm afraid a simple
implementation of pm_runtime_get before reconfiguration may limit the
usage of "power-domains" property for of-fpga-region.

Thanks,
Yilun

>  
> > Since the of-fpga-region driver is a generic fpga-region driver, we may
> > investigate more for a compatible power-domain solution.
> > 
> 
> Please share your thoughts here we will try to align with it.
> 
> Regards,
> Navakishore.
