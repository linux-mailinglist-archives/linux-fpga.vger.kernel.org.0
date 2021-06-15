Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D753A77F7
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 09:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhFOHam (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 03:30:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhFOHam (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 03:30:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E56661407;
        Tue, 15 Jun 2021 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623742117;
        bh=dcUDVTdloGtJr6VEUDDk2fvJlCOM8SNony1ox6mwlgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhgAEhcA6kNpimEE3ALAAmyGEwgT9pkXM574QH76mNBhKzQSbPDduUE8hQPRH2+Cn
         1zJ6imnenvYoJOXMdX4VARpzkpr3SuobrTHNdWgVrw0MHrArr09nJz6zPEYJFHcDkS
         4yIFYBn4mfXhC4rVchgG7hZvl8VmeJlGheyYKO/4=
Date:   Tue, 15 Jun 2021 09:28:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Message-ID: <YMhWomHum8E3v/OT@kroah.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-3-mdf@kernel.org>
 <YMeSG6puw7/4OZ6b@kroah.com>
 <YMeUl0jENlplhWsg@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMeUl0jENlplhWsg@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 10:40:39AM -0700, Moritz Fischer wrote:
> On Mon, Jun 14, 2021 at 07:30:03PM +0200, Greg KH wrote:
> > On Mon, Jun 14, 2021 at 10:09:03AM -0700, Moritz Fischer wrote:
> > > From: Russ Weight <russell.h.weight@intel.com>
> > > 
> > > The stratix10-soc driver uses fpga_mgr_create() function and is therefore
> > > responsible to call fpga_mgr_free() to release the class driver resources.
> > > Add a missing call to fpga_mgr_free in the s10_remove() function.
> > > 
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > >  drivers/fpga/stratix10-soc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > > index 657a70c5fc99..9e34bbbce26e 100644
> > > --- a/drivers/fpga/stratix10-soc.c
> > > +++ b/drivers/fpga/stratix10-soc.c
> > > @@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
> > >  	struct s10_priv *priv = mgr->priv;
> > >  
> > >  	fpga_mgr_unregister(mgr);
> > > +	fpga_mgr_free(mgr);
> > >  	stratix10_svc_free_channel(priv->chan);
> > >  
> > >  	return 0;
> > > -- 
> > > 2.31.1
> > > 
> > 
> > Does this fix a specific commit?  Does it need a Fixes: and cc: stable
> > line too?
> 
> Yes, I missed this. I think this should be:
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager
> driver")
> 
> I can resend with Cc: stable

No need, I fixed this up by hand when I applied it, thanks.

greg k-h
