Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03626D327D
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Apr 2023 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDAPzb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 1 Apr 2023 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAPza (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 1 Apr 2023 11:55:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B820620;
        Sat,  1 Apr 2023 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680364526; x=1711900526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gh91C+ZNgnlHe95VEAG2ZvyvuVbTO3suX8aj+cqURKc=;
  b=A7Iz9/5KUtB8mfSBV71mY5Md0QkuQHVhnnycr3BTT2oBdoEfNUo8BbNM
   1wpo4Qcm9g1w1x6OOsuIUy0+9WBArhHZigFllGm12OX0a04N+y2ZVA81y
   Kdmx47zswHFgX0t/g4jNWDcJj+DOrUxo6BsLuoFMzVF/vj8xUHY9FPZqY
   5hyWHlIhWJZx4m+/C97RNhsCul4kzS+X3br4rrEqSOTQkMPuYGBafnGzh
   HQg31Wk3P2sei9SZKhJoLLuDTKPc+uDwyeh3P3hlYjr/EUiY23BmBBjD/
   5rsRnqtJmBrIOzQsS8Uuw4Z+wBRC9q1X0IEXlO428arbJ9vYlc4wOw0MZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="321319307"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="321319307"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 08:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="662716294"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="662716294"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2023 08:55:23 -0700
Date:   Sat, 1 Apr 2023 23:43:48 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: zynqmp: Make word align the configuration data
Message-ID: <ZChRNHCU273FLkGz@yilunxu-OptiPlex-7050>
References: <20230314094222.66916-1-nava.kishore.manne@amd.com>
 <ZBWDhAaavbrehAjh@yilunxu-OptiPlex-7050>
 <DM6PR12MB399339FED1FDAFEBD0D3A566CD889@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB399339FED1FDAFEBD0D3A566CD889@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-28 at 09:33:17 +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Saturday, March 18, 2023 2:55 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> > michal.simek@xilinx.com; linux-fpga@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] fpga: zynqmp: Make word align the configuration data
> > 
> > On 2023-03-14 at 15:12:22 +0530, Nava kishore Manne wrote:
> > > To avoid unwanted copies at firmware(PMUFW) this patch provides a fix
> > 
> > The copy happens in firmware? Please help briefly describe the firmware
> > operations in commit message.
> > 
> 
> Yes, If the firmware receives unaligned Bitstream file from Linux to make them align
> it will do one more copy at firmware and this copy takes much time as firmware code
> runs on microblaze(32-bit processor and runs at lower frequency). 
> So, we suggested the users to handle the alignment issues at top layers(Before submitting request to the firmware).
> 
> Will update the description in v2.
> 
> > > to align programmable logic(PL) configuration data if the data is not
> > > word-aligned. To align the configuration data this patch adds a few
> > > padding bytes and these additional padding bytes will not create any
> > > functional impact on the PL configuration.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > ---
> > >  drivers/fpga/zynqmp-fpga.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > > index c60f20949c47..70a12dc6e15c 100644
> > > --- a/drivers/fpga/zynqmp-fpga.c
> > > +++ b/drivers/fpga/zynqmp-fpga.c
> > > @@ -15,6 +15,9 @@
> > >  /* Constant Definitions */
> > >  #define IXR_FPGA_DONE_MASK	BIT(3)
> > >
> > > +#define DUMMY_PAD_BYTE		0xFF
> > > +#define FPGA_WORD_SIZE		4
> > > +
> > >  /**
> > >   * struct zynqmp_fpga_priv - Private data structure
> > >   * @dev:	Device data structure
> > > @@ -41,18 +44,26 @@ static int zynqmp_fpga_ops_write(struct
> > fpga_manager *mgr,
> > >  				 const char *buf, size_t size)
> > >  {
> > >  	struct zynqmp_fpga_priv *priv;
> > > +	int word_align, ret, index;
> > >  	dma_addr_t dma_addr;
> > >  	u32 eemi_flags = 0;
> > >  	char *kbuf;
> > > -	int ret;
> > >
> > >  	priv = mgr->priv;
> > > +	word_align = size % FPGA_WORD_SIZE;
> > > +	if (word_align)
> > > +		word_align = FPGA_WORD_SIZE - word_align;
> > > +
> > > +	size = size + word_align;
> > 
> > Does the Macro ALIGN() help?
> > 
> 
> Will fix in v2.
> 
> > >
> > >  	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr,
> > GFP_KERNEL);
> > >  	if (!kbuf)
> > >  		return -ENOMEM;
> > >
> > > -	memcpy(kbuf, buf, size);
> > 
> > This is historical, but why do the realloc & copy? Any better way?
> > 
> 
> Firmware internally uses the AXI DMA engine to transfer PL data from memory to the device
> and it supports only continues DMA-able memory access(It will not support scatter-gather memory access).
> So, this extra copy is needed to copy the data from kernel memory(allocated by the firmware subsystem using page allocators)

I see, but seems the issues are generic. Same issues for versal-fpga

1. fpga_mgr_buf_load_mapped(), fpgamanager_ops::write are intended for
   contiguous (and maybe dma-safe) buffer but fpga_mgr_firmware_load()
   breaks this. This may also affect spi backend drivers.

2. Some drivers needs dma addr rather than cpu addr, this could be
   generally supported. But allocating a bounce buffer by
   dma_alloc_coherent() is not a good idea.

3. fpga_manager_ops::write() may also be called for each fragment of a
   sg buffer, could the firmware OK to handle this case?

I think framework refactoring is needed for these issues. I may not have
time to do the refactoring but will support these topics in first
priority.

Thanks,
Yilun

> to continues DMA-able memory.
>  
> > > +	for (index = 0; index < word_align; index++)
> > > +		kbuf[index] = DUMMY_PAD_BYTE;
> > > +
> > > +	memcpy(&kbuf[index], buf, size - index);
> > 
> > Generally I object to massive copy in fpga_manager_ops::write if not
> > necessary. If there is an alignment requirement from HW, it should be
> > noticed to the caller in some way, before the buffer is created.
> > 
> 
> Agree, we should find a way to support this kind of use cases. 
> 
> Regards,
> Navakishore.
> 
