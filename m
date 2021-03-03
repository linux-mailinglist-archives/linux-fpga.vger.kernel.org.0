Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788C432C887
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 02:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbhCDAvD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Mar 2021 19:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhCDAAu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 Mar 2021 19:00:50 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E91DC06175F;
        Wed,  3 Mar 2021 15:12:08 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id l7so13189751pfd.3;
        Wed, 03 Mar 2021 15:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVf1ZzqnDwgRm+R0xLH7iG9bt5jJx65TM96nbApldLk=;
        b=lCFVWy3OsKPv0U0/aIKwkg6ICvLLETQNliPYx9Hff+VHW043qd+LMVfU2AYUcSwSfZ
         LLdbjm4s+MzpHPhs1b6067Ot1SsHQ66IZlHd2wffv5kqtkb0o+hDz5DZe+RmKVYUHlSR
         hwL+GwyKCtWxEhgYhzdMOhcQpkRjgOVTalw2pQ1zhsU6zJSX787dtDVxYhPLpuTaCNUm
         A5HG0XEFwNEBQaYJ37xDQ1MO4aia1Yd2IWRoBmVLDtRsXUmTcj5kOmxSI3L0jw3pTjNC
         nMKWYipuI9beDuhPZiGNIHHjQM6zEjVj8wxwqjwHkuqJH7klafouf/KWiFkjjv2NbEC3
         h2iA==
X-Gm-Message-State: AOAM530NT8CP2w9nbXtIRrGgSKQ7bbqNKNmzSiTQwefi9A4wgiP0k1TB
        KgbHVIZngusSdLwQO5kr0j4=
X-Google-Smtp-Source: ABdhPJypcbsrOH+c1S75BAXn+Z/NciXbC/GIVjTOGWi22I6ehV2xXikPNH2pCSGrGmYCJupDVg9GSQ==
X-Received: by 2002:a63:e04d:: with SMTP id n13mr1074046pgj.185.1614813127492;
        Wed, 03 Mar 2021 15:12:07 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id mp19sm8656739pjb.2.2021.03.03.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:12:06 -0800 (PST)
Date:   Wed, 3 Mar 2021 15:12:06 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>, trix@redhat.com,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, chinnikishore369@gmail.com
Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Message-ID: <YEAXxuU2J1yaAl3U@archbook>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YApf1jlEghbnDFo/@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nava,

On Thu, Jan 21, 2021 at 09:17:10PM -0800, Moritz Fischer wrote:
> On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne wrote:
> > This commit adds secure flags to the framework to support
> > secure BitStream Loading.
> > 
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> >  include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> > index e405309baadc..3a5eb4808888 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -228,6 +228,16 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
> >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> >  		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
> >  
> > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-config"))
> > +		info->flags |= FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> 
> Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> > +
> > +	if (of_property_read_bool(overlay, "ddrmem-authenticated-fpga-config"))
> > +		info->flags |= FPGA_MGR_DDR_MEM_AUTH_BITSTREAM;
> > +
> > +	if (of_property_read_bool(overlay,
> > +				  "securemem-authenticated-fpga-config"))
> > +		info->flags |= FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM;
Shouldn't all these get binding docs? I remember Richard adding
authentication support for an Intel platform, too and I'd like to avoid
adding random bindings per vendor.

Would it be possible to have an 'authentication method / type' that is more
extensible with different methods maybe?

> > +
> >  	if (!of_property_read_string(overlay, "firmware-name",
> >  				     &firmware_name)) {
> >  		info->firmware_name = devm_kstrdup(dev, firmware_name,
> > diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> > index 2bc3030a69e5..2f7455a60666 100644
> > --- a/include/linux/fpga/fpga-mgr.h
> > +++ b/include/linux/fpga/fpga-mgr.h
> > @@ -67,12 +67,24 @@ enum fpga_mgr_states {
> >   * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
> >   *
> >   * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> > + *
> > + * %FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted with
> > + *                                        user key
> > + *
> > + * %FPGA_MGR_DDR_MEM_AUTH_BITSTREAM: do bitstream authentication using DDR
> > + *                                   memory if supported
> > + *
> > + * %FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM: do bitstream authentication using secure
> > + *                                      memory if supported
> >   */
> >  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
> >  #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
> >  #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
> >  #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
> >  #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
> > +#define FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM	BIT(5)
> > +#define FPGA_MGR_DDR_MEM_AUTH_BITSTREAM		BIT(6)
> > +#define FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM	BIT(7)
> >  
> >  /**
> >   * struct fpga_image_info - information specific to a FPGA image
> > -- 
> > 2.18.0
> > 
> 
> Thanks,
> Moritz
Moritz
