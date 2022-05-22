Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30CF53037E
	for <lists+linux-fpga@lfdr.de>; Sun, 22 May 2022 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbiEVOUo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 22 May 2022 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiEVOUn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 22 May 2022 10:20:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E2393F4;
        Sun, 22 May 2022 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653229242; x=1684765242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dnsZgBhs9A3uGidq6HnfcAZEYWg1tr5b83aPqknMOhQ=;
  b=Ot2FSlk9fTI8gmBcv4dPDXZF5ppH2lSIoEeIUQx8EqDU6iviq9E2WXQw
   t/OHYfD9im2+7Je6kQR9ExQybun1CMps89U1NAhiF8Zz4SSqrMzhPUtQD
   X4noHX4Cu2ekyQicPUlFALlfnzSqWiFWvpZEcKekPhxGqjMWZU1meWKct
   AWJegSkkn9SFvz0UsYmNXq07TPq3TWkrNsPg4avRCI8OldzZri/dI0LbS
   tbd3r4Z5Ln14u3s5RFVaWslg6F7RZaNOw2t0BWe4AlBrpa9UH3tTH7g5y
   dY25CoIb+RCCX9ynKJt8wNtAKKCZs6D5jZMYgefpK72vfoiNpizrqdZDH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="255057737"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="255057737"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 07:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="571638117"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 22 May 2022 07:20:38 -0700
Date:   Sun, 22 May 2022 22:13:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v12 1/3] fpga: fpga-mgr: support bitstream offset in
  image buffer
Message-ID: <20220522141301.GA90764@yilunxu-OptiPlex-7050>
References: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
 <20220513162755.16201-2-i.bornyakov@metrotek.ru>
 <20220522130145.GA89204@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522130145.GA89204@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, May 22, 2022 at 09:01:45PM +0800, Xu Yilun wrote:
> On Fri, May 13, 2022 at 07:27:53PM +0300, Ivan Bornyakov wrote:
> > At the moment FPGA manager core loads to the device entire image
> > provided to fpga_mgr_load(). But it is not always whole FPGA image
> > buffer meant to be written to the device. In particular, .dat formatted
> > image for Microchip MPF contains meta info in the header that is not
> > meant to be written to the device. This is issue for those low level
> > drivers that loads data to the device with write() fpga_manager_ops
> > callback, since write() can be called in iterator over scatter-gather
> > table, not only linear image buffer. On the other hand, write_sg()
> > callback is provided with whole image in scatter-gather form and can
> > decide itself which part should be sent to the device.
> > 
> > Add header_size and data_size to the fpga_image_info struct and adjust
> > fpga_mgr_write() callers with respect to them.
> > 
> >   * info->header_size indicates part at the beginning of image buffer
> >     that is *not* meant to be written to the device. It is optional and
> >     can be 0.
> > 
> >   * info->data_size is the size of actual bitstream data that *is* meant
> >     to be written to the device, starting at info->header_size from the
> >     beginning of image buffer. It is also optional and can be 0, which
> >     means bitstream data is up to the end of image buffer.
> > 
> > Also add parse_header() callback to fpga_manager_ops, which purpose is
> > to set info->header_size and info->data_size. At least
> > initial_header_size bytes of image buffer will be passed into
> > parse_header() first time. If it is not enough, parse_header() should
> > set desired size into info->header_size and return -EAGAIN, than it will
> > be called again with greater part of image buffer on the input.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >  drivers/fpga/fpga-mgr.c       | 150 ++++++++++++++++++++++++++--------
> >  include/linux/fpga/fpga-mgr.h |  13 ++-
> >  2 files changed, 127 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index a3595ecc3f79..c6ca395909a0 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -74,6 +74,15 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
> >  	return 0;
> >  }
> >  
> > +static inline int fpga_mgr_parse_header(struct fpga_manager *mgr,
> > +					struct fpga_image_info *info,
> > +					const char *buf, size_t count)
> > +{
> > +	if (buf && mgr->mops->parse_header)
> > +		return mgr->mops->parse_header(mgr, info, buf, count);
> > +	return 0;
> > +}
> > +
> >  static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
> >  				      struct fpga_image_info *info,
> >  				      const char *buf, size_t count)
> > @@ -136,32 +145,61 @@ void fpga_image_info_free(struct fpga_image_info *info)
> >  EXPORT_SYMBOL_GPL(fpga_image_info_free);
> >  
> >  /*
> > - * Call the low level driver's write_init function.  This will do the
> > - * device-specific things to get the FPGA into the state where it is ready to
> > - * receive an FPGA image. The low level driver only gets to see the first
> > - * initial_header_size bytes in the buffer.
> > + * Call the low level driver's parse_header then write_init functions.
> > + * This will do the device-specific things to get the FPGA into the state
> > + * where it is ready to receive an FPGA image. If parse_header sets
> > + * info->header_size, the low level driver's write_init only gets to see the
> > + * first info->header_size bytes in the buffer, mgr->mops->initial_header_size
> > + * otherwise. If neither initial_header_size nor header_size are not set,
> > + * write_init will not get any bytes of image buffer.
> 
> Could we always initialize the info->header_size = initial_header_size
> at early stage, maybe in fpga_mgr_load(), and only query
> info->header_size afterward. This is to make the logic for header size
> simpler.

Sorry I remember some existing drivers are using initial_header_size but
still deal with no buffer offset in write(), so we cannot force
info->header_size be filled. Forget about the previous comment.

Thanks,
Yilun
