Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67DB6E1B2A
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Apr 2023 06:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDNEkI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Apr 2023 00:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDNEkG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Apr 2023 00:40:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974D2D78;
        Thu, 13 Apr 2023 21:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681447204; x=1712983204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J0V3d0FklsfCJi+UN9UxEYZSMux7pKCvze06tCtbiuU=;
  b=ITwdESv2D7XnLsFzH8CN8f4hTKHS0Fat2iZY3UCuXwfWWCNXU/AOKxwu
   U61l0zdnqByZXtqYH9/YdleiARW+sK/ktLLKsQdYimpqfts7clmgjOGD0
   m4iGRn64MAHupJblS1CdTpav0jIcFM1cWGuTBNeUIkZrKBgEzwp2n27ZI
   +vBep1Q+S9dSWEjFbuyft/bNw9sFQ1pyKTzQhMCgx407GV+j4q3E4Myr+
   9V6JpBkAreM4BQXUjubBs/ToIIoHoo7AumvgFKiiTp7eJgweYm5O4Mf/t
   Rr5CPj7BwGnZNzFsQK1DWyH5Nxbsb6GhWj6Fo+E3xNVogXis3Xpm3qIwj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="409579930"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="409579930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 21:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="639952323"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="639952323"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2023 21:39:59 -0700
Date:   Fri, 14 Apr 2023 12:40:38 +0000
From:   Xu Yilun <yilun.xu@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-fpga@vger.kernel.org, conor@kernel.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] fpga: add PolarFire SoC Auto Update support
Message-ID: <ZDlJxrybiWy3Mk4Y@yilunxu-OptiPlex-7050>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
 <20230331071823.956087-7-conor.dooley@microchip.com>
 <ZClfjuLa/pRATwCp@yilunxu-OptiPlex-7050>
 <20230411-tinsmith-matchless-af5c7c41d23b@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-tinsmith-matchless-af5c7c41d23b@wendy>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-11 at 12:51:34 +0100, Conor Dooley wrote:
> On Sun, Apr 02, 2023 at 06:57:18PM +0800, Xu Yilun wrote:
> > On 2023-03-31 at 08:18:22 +0100, Conor Dooley wrote:
> > > Add support for Auto Update reprogramming of the FPGA fabric on
> > > PolarFire SoC, using the fw_upload mechanism a la the
> > > intel-m10-bmc-sec-update driver.
> > 
> > I'm not an expert of MTD and have several concerns about the mtd
> > writing part:
> > 
> > - This seems a generic case that writing a file content into the
> >   driver restricted offset on mtd.
> 
> Right, writing at an offset is pretty generic.
> 
> > - Seems the firmware update interface could be created for mtd device,
> >   like the nvmem interface?
> 
> I'm not entirely sure what you mean by this one.
> Are you saying that there should be a generic way to do "firmware"
> uploads to mtd devices, based on some sort of structure defined in

Yes, I think if the firmware upload interface could be generic, then add
it to the mtd devices, rather than creating a "virtual mtd management"
device as this patch does.

> devicetree etc?
> And perhaps then, this driver would register as a consumer of that
> interface, pushing all of the direct mtd stuff out to that interface?
> 
> > - I assume the purpose of the fw upload interface is to protect
> >   unexpected writing from user. So how to protect the mtd be
> >   written by other user interfaces like mtdchar/block or nvmem?
> 
> I'm not very good with the security knobs so I don't have an answer for
> you here (yet). But your assumption about the rationale here is correct
> and I would like to block access.
> 
> > For other parts:
> > 
> > - directory block check, fw upload don't touch this block, so why check
> >   it in fw upload process.
> 
> I don't know what you mean. The mtd device could be empty and the
> directory would need to be populated with the image address etc.
> Or, it could previously have been used for something else, and then it
> would be required to reconfigure it correctly for Auto Upgrade.
> 
> Maybe I am misunderstanding you?

This directory block content is unrelated to the firmware image, so
could be written before firmware upload interface is created. The
firmware image uploading could be done without touching directory
blocks. That means directory blocks could be set by driver as
no-touch area for firmware uploading interface.

> 
> > 
> > - image verification, no matter pass or fail, fw upload is actually done,
> >   the flash is written and no way to rollback. So may remove from fw
> >   upload process.
> 
> The FPGA is flash based, so writing to the mtd device is not going to
> actually program the FPGA with this content. The original image/bitstream
> in the mtd device is either going to be a) equivalent to what is already
> programmed in the FPGA, b) not an upgrade over what is current in the
> FPGA, c) something that was uploaded since the last time the device was
> restarted.
> I don't think that overwriting any of those is problematic, as if the
> verification fails, the original bitstream will continue being used
> until an image that does actually pass is provided.
> 
> Without doing the verification though, there's no way to tell for certain
> if the FPGA is actually going to perform an upgrade to this new bitstream
> once it is restarted, so I think there is value in keeping this.

I don't mean to remove the support of verification from driver. I say
remove the verification from MTD firmware upload process. You can
use another interface in your driver to verify if FPGA could load the
content in user block at any time.

In my opinion, generic firmware upload interface for MTD could be used
out of FPGA cases, it just deals with writing the image file to the MTD.
Once you have nothing more to write for the image file, the job for the
interface could be successfully done.

> 
> If you're still very sceptical about whether this belongs in
> drivers/fpga, I can always dump it in drivers/soc instead I guess.

I actually don't think this belongs to FPGA domain. My pereference is a
generic MTD firmware upload interface for MTD domain.

But this is just my opinion. You may talk to MTD or SoC maintainers for
final solution.

Thanks,
Yilun

> 
> Cheers,
> Conor.
> 


