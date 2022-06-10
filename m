Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7E546087
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jun 2022 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbiFJIvB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jun 2022 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344251AbiFJIvA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Jun 2022 04:51:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358911D4227;
        Fri, 10 Jun 2022 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654851059; x=1686387059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etC3uz8qUuWgAsIvtsfrLwFYKAKR7aLj+1lVe6qTKuw=;
  b=BDnm5jblDI/BJ1fMpxKz41dTv15Oe8QOoGw/R2kv09jRhZ0TH+WAtbke
   ZCBgF0V8v9QULF9VDLqA/c9aQbBHv873djpIpK5ia/mxyulMfl4MgQ5Yn
   NvNqCNFi0gmI8TAxy0wg9uqXNqx3x+4fzps8N2xI8SyyLpAgU5mwgpDYu
   YoQbL73YQQFhvT19Tway0ChFquZxicfAhPEnM7DrmT4j9+R+VvNlpyPaa
   lRNCHH89mvYGE++wzYnujvKoVJQlm0/GGGWTqu2EP8QEhDBgqVg4Jv1rS
   NsOMvLZe0xY0AcpLnKunsOtQgsyCjUQxNH20HyyMe+yHMcy/ZTM3TatOx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363893926"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363893926"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 01:50:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="638025972"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2022 01:50:55 -0700
Date:   Fri, 10 Jun 2022 16:42:59 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, corbet@lwn.net,
        Ivan Bornyakov <brnkv.i1@gmail.com>,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v17 1/4] fpga: fpga-mgr: support bitstream offset in
  image buffer
Message-ID: <20220610084259.GB693376@yilunxu-OptiPlex-7050>
References: <20220609154752.20781-1-i.bornyakov@metrotek.ru>
 <20220609154752.20781-2-i.bornyakov@metrotek.ru>
 <20220610074311.GA693376@yilunxu-OptiPlex-7050>
 <20220610081342.45x65lxbuxozej57@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081342.45x65lxbuxozej57@x260>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 10, 2022 at 11:13:42AM +0300, Ivan Bornyakov wrote:
> On Fri, Jun 10, 2022 at 03:43:11PM +0800, Xu Yilun wrote:
> > On Thu, Jun 09, 2022 at 06:47:49PM +0300, Ivan Bornyakov wrote:
> > > At the moment FPGA manager core loads to the device entire image
> > > provided to fpga_mgr_load(). But it is not always whole FPGA image
> > > buffer meant to be written to the device. In particular, .dat formatted
> > > image for Microchip MPF contains meta info in the header that is not
> > > meant to be written to the device. This is issue for those low level
> > > drivers that loads data to the device with write() fpga_manager_ops
> > > callback, since write() can be called in iterator over scatter-gather
> > > table, not only linear image buffer. On the other hand, write_sg()
> > > callback is provided with whole image in scatter-gather form and can
> > > decide itself which part should be sent to the device.
> > > 
> > > Add header_size and data_size to the fpga_image_info struct and adjust
> > > fpga_mgr_write() callers with respect to them.
> > > 
> > >   * info->header_size indicates part at the beginning of image buffer
> > >     that is *not* meant to be written to the device. It is optional and
> > >     can be 0.
> > > 
> > >   * info->data_size is the size of actual bitstream data that *is* meant
> > >     to be written to the device, starting at info->header_size from the
> > >     beginning of image buffer. It is also optional and can be 0, which
> > >     means bitstream data is up to the end of image buffer.
> > > 
> > > Also add parse_header() callback to fpga_manager_ops, which purpose is
> > > to set info->header_size and info->data_size. At least
> > > initial_header_size bytes of image buffer will be passed into
> > > parse_header() first time. If it is not enough, parse_header() should
> > > set desired size into info->header_size and return -EAGAIN, then it will
> > > be called again with greater part of image buffer on the input.
> > > 
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > ---
> > >  drivers/fpga/fpga-mgr.c       | 243 +++++++++++++++++++++++++++++-----
> > >  include/linux/fpga/fpga-mgr.h |  17 ++-
> > >  2 files changed, 229 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > > index 08dc85fcd511..0854fbc8f11e 100644
> > > --- a/drivers/fpga/fpga-mgr.c
> > > +++ b/drivers/fpga/fpga-mgr.c
> > 
> > Should we check in fpga_mgr_create, that initial_header_size must not be
> > 0 if parse_header() is defined. If we pass no data to parse_header(),
> > does it make any sense?
> > 
> 
> If FPGA image is mapped, whole buffer will be passed to parse_header(),
> regardless of initial_header_size.
> 
> If FPGA image is sg_table and initial_header_size is 0, first sg
> fragment will be passed to parse_header() in
> fpga_mgr_parse_header_sg_first().
> 
> If low level driver's parse_header() is buggy and return -EAGAIN without
> setting desired size into info->header_size, we will fail in
> fpga_mgr_parse_header_sg() with -ENOMEM.
> 
> static ssize_t fpga_mgr_parse_header_sg(...)
> {
> 	size_t header_size = mgr->mops->initial_header_size; /* header_size == 0 */
> 	...
> 
> 	do {
> 		if (info->header_size) /* header_size is still 0 */
> 			header_size = info->header_size;
> 
> 		buf = krealloc(buf, header_size, GFP_KERNEL); /* returned buf will be NULL */
> 		if (!buf) {
> 			ret = -ENOMEM;
> 			break;
> 		}
> 
> 		...
> 
> 	} while (ret == -EAGAIN);
> 
> 	...
> }
> 
> So, I believe it is OK to define parse_header() without defining
> initial_header_size.

That's good to me.

> 
> > > @@ -74,6 +74,15 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
> > >  	return 0;
> > >  }
> > >  
> > > +static inline int fpga_mgr_parse_header(struct fpga_manager *mgr,
> > > +					struct fpga_image_info *info,
> > > +					const char *buf, size_t count)
> > > +{
> > > +	if (mgr->mops->parse_header)
> > > +		return mgr->mops->parse_header(mgr, info, buf, count);
> > > +	return 0;
> > > +}
> > > +
> > >  static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
> > >  				      struct fpga_image_info *info,
> > >  				      const char *buf, size_t count)
> > > @@ -136,24 +145,145 @@ void fpga_image_info_free(struct fpga_image_info *info)
> > >  EXPORT_SYMBOL_GPL(fpga_image_info_free);
> > >  
> > >  /*
> > > - * Call the low level driver's write_init function.  This will do the
> > > + * Call the low level driver's parse_header function with entire FPGA image
> > > + * buffer on the input. This will set info->header_size and info->data_size.
> > > + */
> > > +static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
> > > +					struct fpga_image_info *info,
> > > +					const char *buf, size_t count)
> > > +{
> > > +	int ret;
> > > +
> > > +	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> > > +	ret = fpga_mgr_parse_header(mgr, info, buf, count);
> > > +
> > > +	if (info->header_size + info->data_size > count) {
> > > +		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
> > > +		ret = -EINVAL;
> > > +	}
> > > +
> > > +	if (ret) {
> > > +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> > > +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * Call the low level driver's parse_header function with first fragment of
> > > + * scattered FPGA image on the input. If header fits first fragment,
> > > + * parse_header will set info->header_size and info->data_size. If it is not,
> > > + * parse_header will set desired size to info->header_size and -EAGAIN will be
> > > + * returned.
> > > + */
> > > +static int fpga_mgr_parse_header_sg_first(struct fpga_manager *mgr,
> > > +					  struct fpga_image_info *info,
> > > +					  struct sg_table *sgt)
> > > +{
> > > +	size_t header_size = mgr->mops->initial_header_size;
> > > +	struct sg_mapping_iter miter;
> > > +	int ret;
> > > +
> > > +	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> > > +
> > > +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> > > +	if (sg_miter_next(&miter) &&
> > > +	    miter.length >= header_size)
> > > +		ret = fpga_mgr_parse_header(mgr, info, miter.addr, miter.length);
> > > +	else
> > > +		ret = -EAGAIN;
> > > +	sg_miter_stop(&miter);
> > > +
> > > +	if (ret && ret != -EAGAIN) {
> > > +		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
> > > +		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * Copy scattered FPGA image fragments to temporary buffer and call the
> > > + * low level driver's parse_header function. This should be called after
> > > + * fpga_mgr_parse_header_sg_first() returned -EAGAIN. In case of success,
> > > + * pointer to the newly allocated image header copy will be set into *ret_buf
> > > + * and its size will be returned. *ret_buf needs to be freed by caller.
> > > + */
> > > +static ssize_t fpga_mgr_parse_header_sg(struct fpga_manager *mgr,
> > > +					struct fpga_image_info *info,
> > > +					struct sg_table *sgt, char **ret_buf)
> > 
> > Since the function allocs buffer for the user, I suggest it still returns
> > the buffer pointer. The buffer size could be an output parameter.
> > 
> 
> OK, will do that.
> 
> > > +{
> > > +	size_t len, header_size = mgr->mops->initial_header_size;
> > > +	char *buf = NULL;
> > > +	int ret;
> > > +
> > > +	do {
> > > +		if (info->header_size)
> > > +			header_size = info->header_size;
> > > +
> > > +		buf = krealloc(buf, header_size, GFP_KERNEL);
> > > +		if (!buf) {
> > > +			ret = -ENOMEM;
> > 
> > If you need to return ERROR value, ERR_PTR() could be used.
> > 
> > 
> > BTW: Have you tried to test your FPGA programming using sg buffers? I want
> > to ensure these changes are actually tested?
> > 
> 
> Of course, but not every single error path, to be honest. Yet, I'm
> trying my best.

That's fine. Thanks for your support.
