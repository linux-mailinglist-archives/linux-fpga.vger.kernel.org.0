Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9F662EBF
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 19:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjAISUd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 13:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjAISUB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 13:20:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D565F4E;
        Mon,  9 Jan 2023 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673288253; x=1704824253;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=cX8hNu/kXqFhEaU/swi7wdtMmf6CjBQz1mHBUebItQ8=;
  b=AnmuoTZuEDkouUaKVEI3RKObufJoxiKgjHPoLLXF5SxcpsNPXNacV80C
   xsJmqA+q4yNSlhR9xKwysgCax12ut8/PphacZaJQxnL35QinG3H8/lEur
   /M8WMGs/bfHsET5yIEjjf0+/GQmTtXiIJoMte2HFgntBnleS1odmx9lYv
   GKt3FMatlH7TQcKuRtlYHon+zQHtB39eBfqHA3tszlpAKO9vAW7QVLNa6
   FQYhJgy4EaEQdxYiFBdVlw0Q7FAlS7iJHyPX9mos6MWzJzAsywPa6Z7Or
   ZRDZGqkFhq0MS3In1TDJimzQsClso8MWtFrv8tlNewr7SML5kOHuE21Sd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="320643305"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="320643305"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 10:17:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656758245"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656758245"
Received: from aabdilla-mobl.amr.corp.intel.com ([10.251.221.240])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 10:17:29 -0800
Date:   Mon, 9 Jan 2023 20:17:32 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] mfd: intel-m10-bmc: Rename the local
 variables
In-Reply-To: <Y7xXzxqG+9Sv/Nf9@google.com>
Message-ID: <c35cb9ff-dc16-a897-4721-931020995cf8@linux.intel.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com> <20221226175849.13056-3-ilpo.jarvinen@linux.intel.com> <Y7xXzxqG+9Sv/Nf9@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1833037273-1673287927=:1694"
Content-ID: <225bb90-ac7e-ec66-7dc8-7c2560c447f3@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1833037273-1673287927=:1694
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d4678c30-5f7d-ceb7-aca7-391fb041ed2@linux.intel.com>

On Mon, 9 Jan 2023, Lee Jones wrote:

> On Mon, 26 Dec 2022, Ilpo Järvinen wrote:
> 
> > Local variables directly interact with dev_get_drvdata/dev_set_drvdata
> > should be named ddata.
> > 
> > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> 
> It took 2 people to rename some variables? :)

It took one person to rename the variables, and other to prepare it into a 
series which required some changes to the original patch (which is when 
I added my SoB). But I can remove Tianfei (Andy mentioned earlier for 
simple changes it's okay).

-- 
 i.

> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index 12c522c16d83..2c26203c4799 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -81,15 +81,15 @@ static DEVICE_ATTR_RO(bmcfw_version);
> >  static ssize_t mac_address_show(struct device *dev,
> >  				struct device_attribute *attr, char *buf)
> >  {
> > -	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> > +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
> 
> In general I'm all for the use of 'ddata' for driver data.
> 
> For my own reference (apply this as-is to your sign-off block):
>                                                        
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>

--8323329-1833037273-1673287927=:1694--
