Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50184545E4B
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jun 2022 10:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbiFJIMu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jun 2022 04:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiFJIMi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Jun 2022 04:12:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20857A0D13;
        Fri, 10 Jun 2022 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654848758; x=1686384758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ebnKv878WSMZ5HcFOwZsfEn/i/Ra3ih4STyQ85qlVN0=;
  b=Cj6eQJPufU8Bc2sIxhnW9fIojAfBShlY7UkNJUVnw5uzGvMk15nAnue1
   d+SQ4I6VYDtxbceHsaYUKnuHod4ElG1i8BFDsM1PFMHSdiAqAgY/ti8j7
   qhv47S07YrFXmV+eWd1wHIWOY3SEYrErcUgyVZSaqSUul9Eb86l/Gj8R0
   eWa9VfjsqHHSWEeQmhdLm61ezD7OKprsiy8lU8Ff56gExALpxtyWxqNRx
   SUYDVl+O9rD9zN9JNg/4FXhl/Sxx/e0UKUKkMUESM3wBiGZZ+NXemg7jV
   HWCIsEEq4QCkeaXAqTXbmxDmJ/2q2faEwS+tYp8iXkmTsteg5DJLlUU+z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276330380"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276330380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 01:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="684424712"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2022 01:12:34 -0700
Date:   Fri, 10 Jun 2022 16:04:38 +0800
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
Message-ID: <20220610080438.GB713676@yilunxu-OptiPlex-7050>
References: <20220609154752.20781-1-i.bornyakov@metrotek.ru>
 <20220609154752.20781-2-i.bornyakov@metrotek.ru>
 <20220610074311.GA693376@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610074311.GA693376@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 10, 2022 at 03:43:11PM +0800, Xu Yilun wrote:
> On Thu, Jun 09, 2022 at 06:47:49PM +0300, Ivan Bornyakov wrote:
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
> > set desired size into info->header_size and return -EAGAIN, then it will
> > be called again with greater part of image buffer on the input.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >  drivers/fpga/fpga-mgr.c       | 243 +++++++++++++++++++++++++++++-----
> >  include/linux/fpga/fpga-mgr.h |  17 ++-
> >  2 files changed, 229 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index 08dc85fcd511..0854fbc8f11e 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> 
> Should we check in fpga_mgr_create, that initial_header_size must not be
> 0 if parse_header() is defined. If we pass no data to parse_header(),
> does it make any sense?

Sorry, there is no fpga_mgr_create now, should be fpga_mgr_register_full

Thanks,
Yilun
