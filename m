Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23950597BFE
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Aug 2022 05:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiHRDHR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Aug 2022 23:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiHRDHP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Aug 2022 23:07:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CEE51419;
        Wed, 17 Aug 2022 20:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660792034; x=1692328034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=paaeyTrbMBIZzJAEm8UJW/v3a75y7c1pQy4y5buXMcY=;
  b=PuLPEBAc656ipuKBPMPEY4sSOlQP9kASR1fUqR2HWBirv7+W7Au5TDc7
   f2/b195BReI42A2BoSapPbPXO8h5d78Yd8xETtGuDUZlthY5vlo+tQ/Hx
   xWptsNGTlN5aKu/XC5TPrXbaoaAfpRjc+4NS4GmYTXhbhDtJ0xi8rhBac
   cG7fb6J2XBqxs6NKv4Aqkkd5+j1Mbs95fLBDxrRwWT9HYQX2YFYFWJFfe
   QnaxU1CG2fL2ZSu5IhwTXZpTJynFQaFSCacU2pplbUSxMwxAOhOW8ngtO
   iDqAgRn9FawC2jc7iQ4ON68xOQa8uxFhd6DrbX/+4ITFhAHS3e7fu25Bm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292651209"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="292651209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 20:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="636638805"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 20:07:10 -0700
Date:   Thu, 18 Aug 2022 10:58:03 +0800
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
Message-ID: <Yv2qu2pUh7U5ntcl@yilunxu-OptiPlex-7050>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-3-nava.manne@xilinx.com>
 <20220624162815.GA2142910@yilunxu-OptiPlex-7050>
 <DM6PR12MB39937A19AE147CD9105C8D52CD8C9@DM6PR12MB3993.namprd12.prod.outlook.com>
 <20220721065454.GA1689481@yilunxu-OptiPlex-7050>
 <DM6PR12MB39935950EC1E2998075E0A1DCD6B9@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB39935950EC1E2998075E0A1DCD6B9@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-16 at 10:22:28 +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Thursday, July 21, 2022 12:25 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: Nava kishore Manne <nava.manne@xilinx.com>; mdf@kernel.org;
> > hao.wu@intel.com; trix@redhat.com; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com; linux-
> > fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > git@xilinx.com; Rob Herring <robh@kernel.org>
> > Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
> > property
> > 
> > On Mon, Jul 18, 2022 at 06:46:32AM +0000, Manne, Nava kishore wrote:
> > > Hi Yilun,
> > >
> > > 	Please find my response inline.
> > >
> > > > -----Original Message-----
> > > > From: Xu Yilun <yilun.xu@intel.com>
> > > > Sent: Friday, June 24, 2022 9:58 PM
> > > > To: Nava kishore Manne <nava.manne@xilinx.com>
> > > > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> > > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > michal.simek@xilinx.com; linux-fpga@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > > > kernel@lists.infradead.org; git@xilinx.com; Rob Herring
> > > > <robh@kernel.org>
> > > > Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-
> > domains'
> > > > property
> > > >
> > > > CAUTION: This message has originated from an External Source. Please
> > > > use proper judgment and caution when opening attachments, clicking
> > > > links, or responding to this email.
> > > >
> > > >
> > > > On Mon, May 23, 2022 at 07:15:16PM +0530, Nava kishore Manne wrote:
> > > > > Add fpga-region 'power-domains' property to allow to handle the
> > > > > FPGA/PL power domains.
> > > > >
> > > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > > Changes for v2:
> > > > >               - Updated power-domains description.
> > > > >
> > > > >  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > > index 7d3515264838..f299c3749505 100644
> > > > > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > > @@ -196,6 +196,20 @@ Optional properties:
> > > > >  - config-complete-timeout-us : The maximum time in microseconds
> > > > > time
> > > > for the
> > > > >       FPGA to go to operating mode after the region has been
> > programmed.
> > > > >  - child nodes : devices in the FPGA after programming.
> > > > > +- power-domains : A phandle and power domain specifier pair to
> > > > > +the
> > > > power domain
> > > > > +     which is responsible for turning on/off the power to the
> > > > > + FPGA/PL
> > > > region.
> > > >
> > > > Could you help explain what is PL?
> > > >
> > > > > +Example:
> > > > > +     fpga_full: fpga-full {
> > > > > +                compatible = "fpga-region";
> > > > > +                fpga-mgr = <&zynqmp_pcap>;
> > > > > +                #address-cells = <2>;
> > > > > +                #size-cells = <2>;
> > > > > +                ranges;
> > > > > +                power-domains = <&zynqmp_firmware PL_PD>;
> > > > > +        };
> > > > > +
> > > > > +     The PL_PD power domain will be turned on before loading the
> > > > > +bitstream and turned off while removing/unloading the bitstream
> > > > > +using
> > > > overlays.
> > > >
> > > > I think the single power-domain may not cover some use cases that
> > > > of-fpga- region driver supports.
> > >
> > > I am not sure which use case you are talking about. Can you please point
> > me the exact use case here?
> > >
> > > > It is possible there are already devices in fpga-region for static
> > > > OF tree, or an overlay with no 'firmware-name' but 'external-fpga-
> > > > config'. In these cases power domains may still be needed, is it?
> > > >
> > >
> > > It's an optional property user can decide whether he needs this
> > > support or not for 'external-fpga-config Use case.
> > 
> > If an external-fpga-config FPGA region needs to enable a power domain
> > before sub devices population, how could it config the DT? I assume in this
> > patch "power-domains" property is only used before & after reconfiguration
> > but external-fpga-config FPGA region may need no reconfiguration.
> > 
> I agree, For 'external-fpga-config' use case this patch is not capable of supporting the dynamic PM.
> I Will explore and get back to you to handle this use case.
> 
> > >
> > > > Another case is the fpga-region may need multiple power domains?
> > > >
> > >
> > > In our use case full region and relevant partial regions have
> > > different power domains and this patch is capable of handle different
> > > power domain regions (full and partial regions)
> > 
> > If a FPGA region needs 2 or more power domains for partial reconfiguration,
> > how could we find out and enable them all?
> > 
> > From the 2 cases, I see as a generic driver, there may be need to enable
> > different power domains at different moments. And I'm afraid a simple
> > implementation of pm_runtime_get before reconfiguration may limit the
> > usage of "power-domains" property for of-fpga-region.
> > 
> 
> Can you please point me any references to handle the multiple power domains?

Some devices may need multiple domains to work properly, for example:

	power-domains = <&pd_disp>, <&pd_pci>;
	power-domain-names = "pcie", "pcie_phy";

I'm not sure if there is need for some fpga region, but think it could be
a valid usecase.

Thanks,
Yilun

> 
> This implementation is region specific which means it can handle both full and partial power domains
> Independently based on the power domains info exists in the DT.
> For example:
> 
> Base DT: For full
> fpga_full: fpga-full {
>                 compatible = "fpga-region";
>                 fpga-mgr = <&zynqmp_pcap>;
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
>                 power-domains = <&zynqmp_firmware PL_PD>;
> };
> 
> Overlay DT: For Partial
> fragment@0 {
> 	target = <&fpga_full>;
> 	#address-cells = <2>;
> 	#size-cells = <2>;
> 	 __overlay__ {
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 		firmware-name = "full.bin";
> 		fpga_PR0: fpga-PR0 {
> 			compatible = "fpga-region";
> 			#address-cells = <2>;
> 			#size-cells = <2>;
> 			ranges;
> 			power-domains = <&zynqmp_firmware PL_PR_PD>;
> 		};
> 	 };
> };
> 
> Regards,
> Navakishore.
