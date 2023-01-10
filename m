Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E958663DB6
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Jan 2023 11:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjAJKNh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Jan 2023 05:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjAJKNb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Jan 2023 05:13:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4032C759;
        Tue, 10 Jan 2023 02:13:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F5EA61586;
        Tue, 10 Jan 2023 10:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4051CC433F2;
        Tue, 10 Jan 2023 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673345610;
        bh=SnvkqEhLd09ugaM10bvD3ElpJbUNEcWAngfeAOXd5N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mll4gLKa48vWvuHjN5jOL0zrJb6uKMUaqxeiJHKnD03ecS6aHIcWjP0j21nMLN93e
         7upO4q6CX2nkDC5dNXkD+jVm9gDqdrYvllPbm3Dl+4+YECwWGKDlbX7Ws+/7JT1B5/
         Fc3DXB+HwO0S7Zr71UEjU/is32HbkO4by0rlVlvmiD+aJlxluaNIHVvDX9F51Z4uZW
         Dj4pvkFX/kf/2CLSxv/8Oj4eUimgquzbJYSMPYrSbbWEJxcLhpEtIqV8RTWdv4Smnd
         31S+iYl5YJEuQ6oyDDDrcZLlmSmYpcDH4GFDI2Mm5c8VjTl70PmP7CJnBcgHpEOq3N
         k2fJiSxjZzutA==
Date:   Tue, 10 Jan 2023 10:13:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] mfd: intel-m10-bmc: Rename the local variables
Message-ID: <Y706RErtx9TvpvmB@google.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-3-ilpo.jarvinen@linux.intel.com>
 <Y7xXzxqG+9Sv/Nf9@google.com>
 <c35cb9ff-dc16-a897-4721-931020995cf8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c35cb9ff-dc16-a897-4721-931020995cf8@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 09 Jan 2023, Ilpo Järvinen wrote:

> On Mon, 9 Jan 2023, Lee Jones wrote:
> 
> > On Mon, 26 Dec 2022, Ilpo Järvinen wrote:
> > 
> > > Local variables directly interact with dev_get_drvdata/dev_set_drvdata
> > > should be named ddata.
> > > 
> > > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > 
> > It took 2 people to rename some variables? :)
> 
> It took one person to rename the variables, and other to prepare it into a 
> series which required some changes to the original patch (which is when 
> I added my SoB). But I can remove Tianfei (Andy mentioned earlier for 
> simple changes it's okay).

It's not a blocker.  I just found it humorous. :)

> > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel-m10-bmc.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > > index 12c522c16d83..2c26203c4799 100644
> > > --- a/drivers/mfd/intel-m10-bmc.c
> > > +++ b/drivers/mfd/intel-m10-bmc.c
> > > @@ -81,15 +81,15 @@ static DEVICE_ATTR_RO(bmcfw_version);
> > >  static ssize_t mac_address_show(struct device *dev,
> > >  				struct device_attribute *attr, char *buf)
> > >  {
> > > -	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> > > +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
> > 
> > In general I'm all for the use of 'ddata' for driver data.
> > 
> > For my own reference (apply this as-is to your sign-off block):
> >                                                        
> > Acked-for-MFD-by: Lee Jones <lee@kernel.org>


-- 
Lee Jones [李琼斯]
