Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1B655F72
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 04:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiLZD0H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Dec 2022 22:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLZD0H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Dec 2022 22:26:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012210C8;
        Sun, 25 Dec 2022 19:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672025165; x=1703561165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RvOCkpfPImasNdXFzBkGq3mAVniYgEKHsc2mkMKLAz0=;
  b=nIj3Ud++xpZpD/D0qwaN74Ba1tgj91LCjZpNfYPDHYlxQWmfs/5w7gcp
   7I5M295mqLAc8/L0mzTmMvEz3/Nk816Rt0YbEEFTWtG55Nkj5M+Q0auJ/
   UwHN+xywlGtGF1Pj1/+FUrTsqO0kNyTcA0Alqzs5gQl/M2a6TE3BGcvYq
   5XjIb52NQiHYCq4e+raMPyhDGCa8PNtqUV97G5akdboB/LiaL4n18os8S
   B9I2e222YabVa/jBEQgsLcRfSMuq42eysCJgCpBFYTS3vWThYqMIzt/v4
   AUS5xck0qRco6/H7xOPVcb7Y14V5baWDumP/fqPfdKiHNPyNS5LMVkBiD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="300210122"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="300210122"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 19:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="602690982"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="602690982"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 25 Dec 2022 19:25:59 -0800
Date:   Mon, 26 Dec 2022 11:15:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v7 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y6kR632DYwilj505@yilunxu-OptiPlex-7050>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-4-matthew.gerlach@linux.intel.com>
 <Y6HqyjFkiUDeNmH1@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2212211105490.570436@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212211105490.570436@rhweight-WRK1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-21 at 11:14:59 -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 20 Dec 2022, Andy Shevchenko wrote:
> 
> > On Tue, Dec 20, 2022 at 08:36:51AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Version 1 of the Device Feature Header (DFH) definition adds
> > > functionality to the DFL bus.
> > > 
> > > A DFHv1 header may have one or more parameter blocks that
> > > further describes the HW to SW.  Add support to the DFL bus
> > > to parse the MSI-X parameter.
> > > 
> > > The location of a feature's register set is explicitly
> > > described in DFHv1 and can be relative to the base of the DFHv1
> > > or an absolute address.  Parse the location and pass the information
> > > to DFL driver.
> > 
> > ...
> > 
> > > +/**
> > > + * dfh_find_param() - find data for the given parameter id
> > > + * @dfl_dev: dfl device
> > > + * @param: id of dfl parameter
> > > + *
> > > + * Return: pointer to parameter header on success, NULL otherwise.
> > 
> > header is a bit confusing here, does it mean we give and ID and we got
> > something more than just a data as summary above suggests?
> 
> Yes, the summary is not correct.  It should say "find the parameter block
> for the given parameter id".
> 
> > 
> > In such case summary and this text should clarify what exactly we get
> > and layout of the data. Since this is a pointer, who is responsible of
> > checking out-of-boundary accesses? For instance, if the parameters are
> > variadic by length the length should be returned as well. Otherwise it
> > should be specified as a constant somewhere, right?
> 
> The parameter header has the next/size field; so the caller of
> dfh_find_param should perform boundary checking as part of interpreting the
> parameter data.  I think a function to perform this checking and data
> interpretation would help here.

It is better the DFL core provides the size of the parameter block, just
in this API. It provides the pointer and should be ensured the memory
for the pointer be correctly understood.

> 
> > 
> > > + */
> > > +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
> > > +{
> > > +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dfh_find_param);
> > 
> > ...
> > 
> > > +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);
> > 
> > It sounds like a candidate for struct_size() from overflow.h.
> > I.o.w. check that header and come up with the best what can
> > suit your case.
> 
> 	finfo = kzalloc(struct_size(finfo, params, dfh_psize/sizeof(u64)),
> GFP_KERNEL);
> 
> Does seem better.

How about we change the dfh_get_psize() to like dfh_get_pcount(), so we
don't have to multiply & divide back and forth.

Or we just use size_add()?

Thanks,
Yilun

> 
> Thanks for the suggestion,
> Matthew Gerlach
> 
> 
> > 
> > >  	if (!finfo)
> > >  		return -ENOMEM;
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> > 
