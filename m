Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330885EBAF1
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Sep 2022 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiI0Gqp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Sep 2022 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI0Gqn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Sep 2022 02:46:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21546A00E2;
        Mon, 26 Sep 2022 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664261202; x=1695797202;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UYSRZj7T7ZxjpirfOn+GZ9jSLsE+bkyXb8Mh75XWUEA=;
  b=bhGRdeaPHQZJaEVHiAHvnjRXKHdFH13zP3itfJ3ZSTRY6wDJBQvqd1Kr
   dNv7hscvM0IdOgsvZmpz59BRq4J6SLyIeVROSJNsaV3L7ruQkpjSRIWvQ
   p9XbGaE+thiEhW0HK1s98O7Aufe/BT3NTnhnsKcCFGBGYVNGectnGPR9m
   g0Xu/+abFfiPJOeQjmZeVlaiSlG66Ds13kZ0An4ZG2GrUoCmJV0Q6laM4
   +PhX7cVfVHqsmPb9TiDYFXuTJ1SUQO+uYIHCnmblkaiVXQZ+/I/09uVym
   lHMFkWfCjodJ4CaMxzs60Z8fXvCrFUrbvoGApDbmPj9F58tQhh6uNWcX1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="365280456"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="365280456"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 23:46:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="689882103"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="689882103"
Received: from aksaxena-mobl2.ger.corp.intel.com ([10.252.60.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 23:46:36 -0700
Date:   Tue, 27 Sep 2022 09:46:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <alpine.DEB.2.22.394.2209260734490.363733@rhweight-WRK1>
Message-ID: <609e122-f6a0-c0c2-4168-4025dd96a1ac@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-5-matthew.gerlach@linux.intel.com> <a602677-78ac-23a0-1a63-96b325595998@linux.intel.com> <alpine.DEB.2.22.394.2209260734490.363733@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-529190930-1664261202=:2334"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-529190930-1664261202=:2334
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 26 Sep 2022, matthew.gerlach@linux.intel.com wrote:

> 
> 
> On Fri, 23 Sep 2022, Ilpo Järvinen wrote:
> 
> > On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:
> > 
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Define and use a DFHv1 parameter to add generic support for MSIX
> > > interrupts for DFL devices.
> > > 
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > > v2: fix kernel doc
> > >     clarify use of DFH_VERSION field
> > > ---
> > >  drivers/fpga/dfl.c  | 60 +++++++++++++++++++++++++++++++++++++++++----
> > >  include/linux/dfl.h | 14 +++++++++++
> > >  2 files changed, 69 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > index 1132f3c10440..dfd3f563c92d 100644
> > > --- a/drivers/fpga/dfl.c
> > > +++ b/drivers/fpga/dfl.c
> > > @@ -941,23 +941,22 @@ static int parse_feature_irqs(struct
> > > build_feature_devs_info *binfo,
> > >  	void __iomem *base = binfo->ioaddr + ofst;
> > >  	unsigned int i, ibase, inr = 0;
> > >  	enum dfl_id_type type;
> > > -	int virq;
> > > +	int virq, off;
> > >  	u64 v;
> > > 
> > >  	type = feature_dev_id_type(binfo->feature_dev);
> > > 
> > >  	/*
> > >  	 * Ideally DFL framework should only read info from DFL header, but
> > > -	 * current version DFL only provides mmio resources information for
> > > +	 * current version, DFHv0, only provides mmio resources information
> > > for
> > >  	 * each feature in DFL Header, no field for interrupt resources.
> > >  	 * Interrupt resource information is provided by specific mmio
> > >  	 * registers of each private feature which supports interrupt. So in
> > >  	 * order to parse and assign irq resources, DFL framework has to look
> > >  	 * into specific capability registers of these private features.
> > >  	 *
> > > -	 * Once future DFL version supports generic interrupt resource
> > > -	 * information in common DFL headers, the generic interrupt parsing
> > > -	 * code will be added. But in order to be compatible to old version
> > > +	 * DFHv1 supports generic interrupt resource information in DFHv1
> > > +	 * parameter blocks. But in order to be compatible to old version
> > >  	 * DFL, the driver may still fall back to these quirks.
> > >  	 */
> > >  	if (type == PORT_ID) {
> > > @@ -981,6 +980,36 @@ static int parse_feature_irqs(struct
> > > build_feature_devs_info *binfo,
> > >  		}
> > >  	}
> > > 
> > > +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> > > +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
> > > +
> > > +		v = FIELD_GET(DFH_VERSION, readq(base));
> > 
> > I'd call this variable version (or ver) if you want to store it but it
> > would also fit to switch () line so that no extra variable is needed.
> 
> I will change the v to dfh_ver to be clearer.  I want to store the value
> because it is used in the default case in the error message.  The error
> message helps to debug broken FPGA images.

Right, I missed that (or didn't think it too much and all being called 
"v" didn't help either :-)).

> > > +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> > > +				off = dfl_find_param(base + DFHv1_PARAM_HDR,
> > > ofst,
> > > +						     DFHv1_PARAM_ID_MSIX);
> > > +				if (off >= 0) {
> > 
> > I'd reverse these 2 conditions and break when there's nothing to do.
> 
> I'm not sure what you mean by reversing these conditions because a DFHv1 may
> or may not have parameters (the first condition), and a DFHv1 may have
> parameters but may not have a MSI-X parameter (the second condition).

This is what I meant:

		if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v))
			break;

		off = dfl_find_param(...);
		if (off < 0)
			break;

		ibase = ...


-- 
 i.


> > > +					ibase = readl(base + DFHv1_PARAM_HDR +
> > > +						      off +
> > > DFHv1_PARAM_MSIX_STARTV);
> > > +					inr = readl(base + DFHv1_PARAM_HDR +
> > > +						    off +
> > > DFHv1_PARAM_MSIX_NUMV);
> > > +					dev_dbg(binfo->dev, "start %d num %d
> > > fid 0x%x\n",
> > > +						ibase, inr, fid);
> > > +				}
> > > +			}
> > > +			break;

--8323329-529190930-1664261202=:2334--
