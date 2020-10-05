Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFA9283CB9
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgJEQqA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 12:46:00 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55227 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgJEQqA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 12:46:00 -0400
Received: by mail-pj1-f66.google.com with SMTP id az3so98527pjb.4;
        Mon, 05 Oct 2020 09:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dt/RNrQ4SL4MPuEQRo7CMCIUWEGjo0wgoqzjdBTj0Yk=;
        b=XLnHOpEwXsoaJ2jjP+xMOfB2nGUKyMcw2jm76/ZcRHuXn9XFnHUt4j0GCFl15Y40Bb
         fkSe6+vqfI1B+YBUyajFjoX2TgaE3WyYdw0MtbRM4dvmNCE22AVNp8xsgdDsnuYt64Dq
         17il1ogv2jlHfjW6xByeM0KzlXjq0XtLkYrvnDjDIucQ87jS1cQTLtUcjAZHgpxYFaLY
         p+T1exvSkdOnjLEBzFCj7XxdE130nOI4AQQlG081AA2eM2y91Z3n34g0QlSzEW8AV9bS
         iX9JRf8TxMCRig8gI1O9tY04oTz/GnCV4ASLZgnD1U90WetXKrcL1TkNqcM0W77hzRU9
         gNGA==
X-Gm-Message-State: AOAM5337G2SX1gkhr0+DHwtBEdwnHwaXl2ZaKnH4xzgDbPwTO44c5Kd7
        mzw1hTZGXrH0hBuF3bN4DKY=
X-Google-Smtp-Source: ABdhPJxtxTQiQ0BLq93Fdnp0PeKNKbN4Cbv75Bx9SP0o/TRLQz3L/Xalj2K7vpyTXJShGV4hphd7yw==
X-Received: by 2002:a17:90b:4204:: with SMTP id iw4mr245153pjb.175.1601916359186;
        Mon, 05 Oct 2020 09:45:59 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 31sm132457pgs.59.2020.10.05.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:45:58 -0700 (PDT)
Date:   Mon, 5 Oct 2020 09:45:57 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: Re: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Message-ID: <20201005164557.GA157831@epycbox.lan>
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-2-mdf@kernel.org>
 <DM6PR11MB3819DC09D49EBE947F558F36850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819DC09D49EBE947F558F36850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Hao,

On Mon, Oct 05, 2020 at 05:18:40AM +0000, Wu, Hao wrote:
> > Subject: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
> > 
> > Add a devm_fpga_mgr_register() API that can be used to register a FPGA
> > Manager that was created using devm_fpga_mgr_create().
> > 
> > Introduce a struct fpga_mgr_devres that makes the devres
> > allocation a little bit more readable and gets reused for
> > devm_fpga_mgr_create() devm_fpga_mgr_register().
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/fpga-mgr.c       | 76 ++++++++++++++++++++++++++++++-----
> >  include/linux/fpga/fpga-mgr.h |  2 +
> >  2 files changed, 68 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index f38bab01432e..774ac98fb69c 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -21,6 +21,10 @@
> >  static DEFINE_IDA(fpga_mgr_ida);
> >  static struct class *fpga_mgr_class;
> > 
> > +struct fpga_mgr_devres {
> > +	struct fpga_manager *mgr;
> > +};
> > +
> >  /**
> >   * fpga_image_info_alloc - Allocate a FPGA image info struct
> >   * @dev: owning device
> > @@ -651,21 +655,21 @@ struct fpga_manager
> > *devm_fpga_mgr_create(struct device *dev, const char *name,
> >  					  const struct fpga_manager_ops
> > *mops,
> >  					  void *priv)
> >  {
> > -	struct fpga_manager **ptr, *mgr;
> > +	struct fpga_mgr_devres *dr;
> > 
> > -	ptr = devres_alloc(devm_fpga_mgr_release, sizeof(*ptr),
> > GFP_KERNEL);
> > -	if (!ptr)
> > +	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
> 
> Should we update devm_fpga_mgr_release function to use fpga_mgr_devres as well?
Yes!
> 
> > +	if (!dr)
> >  		return NULL;
> > 
> > -	mgr = fpga_mgr_create(dev, name, mops, priv);
> > -	if (!mgr) {
> > -		devres_free(ptr);
> > -	} else {
> > -		*ptr = mgr;
> > -		devres_add(dev, ptr);
> > +	dr->mgr = fpga_mgr_create(dev, name, mops, priv);
> > +	if (!dr->mgr) {
> > +		devres_free(dr);
> > +		return NULL;
> >  	}
> > 
> > -	return mgr;
> > +	devres_add(dev, dr);
> > +
> > +	return dr->mgr;
> >  }
> >  EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
> > 
> > @@ -722,6 +726,58 @@ void fpga_mgr_unregister(struct fpga_manager
> > *mgr)
> >  }
> >  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
> > 
> > +static int fpga_mgr_devres_match(struct device *dev, void *priv,
> 
> Maybe it's better to use "res" instead of "priv" which matches the
> dr_match_t, and also devm_fpga_mgr_release function. 
Can do.
> 
> > +				 void *match_data)
> > +{
> > +	struct fpga_mgr_devres *dr = priv;
> > +
> > +	return match_data == dr->mgr;
> > +}
> > +
> > +static void devm_fpga_mgr_unregister(struct device *dev, void *priv)
> > +{
> 
> Same.
Ditto.
> 
> > +	struct fpga_mgr_devres *dr = priv;
> > +
> > +	fpga_mgr_unregister(dr->mgr);
> > +}
> > +
> > +/**
> > + * devm_fpga_mgr_register - resource managed variant of
> > fpga_mgr_register()
> > + * @dev: managing device for this FPGA manager
> > + * @mgr: fpga manager struct
> > + *
> > + * This is the devres variant of fpga_mgr_register() for which the unregister
> > + * function will be called automatically when the managing device is
> > detached.
> > + */
> > +int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> > +{
> > +	struct fpga_mgr_devres *dr;
> > +	int err;
> > +
> > +	/* Make sure that the struct fpga_manager * that is passed in is
> > +	 * managed itself.
> > +	 */
> 
> Should we use the same style for code comments here, 
> I see other places in this file are using style like
Can do.
> 
> /*
>   * ......
>   */
> 
> Thanks
> Hao
Thanks,
Moritz
