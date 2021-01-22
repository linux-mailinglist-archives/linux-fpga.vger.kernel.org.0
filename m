Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366852FFC02
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Jan 2021 06:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbhAVFP6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 00:15:58 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:34442 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbhAVFP5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 22 Jan 2021 00:15:57 -0500
Received: by mail-pf1-f177.google.com with SMTP id m6so2965576pfk.1;
        Thu, 21 Jan 2021 21:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w2BUoSFxpHPMOrylOUmPX8q+87J66EYimkKpLqnA9D0=;
        b=J8oPajG17GVN5MLPB9FQe8FiHeGMwPmTerCnqWiD/ub7wbmpRjAgOgtJq0uMLQc0ds
         KIQSQQCIcIKlFIvEyXuIKxF3EaB8u2aSmuoPs8M3hmyAu3yXJrxzfgs1iim91OFpAL3V
         4TONfUp6rBkYARPzAeM+/ezeaTTpwtn8Pv9ms3xY9gtU2/QaTnjn9B0C68j/Fm5OO43k
         mx4bs3kTuw0XYn4v5RkbIzIsUJ5XJctemqmX+c8DX5edSKIL5rLb/GRt8Gmw+Tf7Ruos
         oqqAevlAxcm5RPVZttURjhi+rkmrXcotPlRTI95ycdDPlCvlgzQ3gTVwU1YlCvNwQklu
         gM0Q==
X-Gm-Message-State: AOAM5329tLO0YI7dPOIKaw3V+8zhL+vvlYy5FfwMq55x6DBu16toAukO
        3vmb/L/ow5HmQwSLt7fGmrkrveO6UztaPQ==
X-Google-Smtp-Source: ABdhPJwwCT/KQcIsUg8IFsTLdderKKnMglqlaCXjA6kzauEIBMwS6qd4OmSK9/GFYMf4CQBpKf77RQ==
X-Received: by 2002:a62:800d:0:b029:1bc:9cd1:8ee1 with SMTP id j13-20020a62800d0000b02901bc9cd18ee1mr3276232pfd.69.1611292515962;
        Thu, 21 Jan 2021 21:15:15 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id e5sm7040733pfc.76.2021.01.21.21.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:15:15 -0800 (PST)
Date:   Thu, 21 Jan 2021 21:15:12 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
Message-ID: <YApfYL5swV46IsQG@archbook>
References: <20210115013431.27667-1-nava.manne@xilinx.com>
 <20210115013431.27667-2-nava.manne@xilinx.com>
 <YAJWT4IDPmHneam1@epycbox.lan>
 <MWHPR02MB262353F2D236B6AD787FD5EFC2A30@MWHPR02MB2623.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR02MB262353F2D236B6AD787FD5EFC2A30@MWHPR02MB2623.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jan 19, 2021 at 06:34:54AM +0000, Nava kishore Manne wrote:
> Hi Moritz,
> 
> 	Thanks for the review.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Moritz Fischer <mdf@kernel.org>
> > Sent: Saturday, January 16, 2021 8:28 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> > Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown
> > manager
> > 
> > Hi,
> > 
> > On Fri, Jan 15, 2021 at 07:04:31AM +0530, Nava kishore Manne wrote:
> > > This patch adds support for Xilinx Dynamic Function eXchange(DFX) AXI
> > > shutdown manager IP. It can be used to safely handling the AXI traffic
> > > on a Reconfigurable Partition when it is undergoing dynamic
> > > reconfiguration and there by preventing system deadlock that may occur
> > > if AXI transactions are interrupted during reconfiguration.
> > >
> > > PR-Decoupler and AXI shutdown manager are completely different IPs.
> > > But both the IP registers are compatible and also both belong to the
> > > same sub-system (fpga-bridge).So using same driver for both IP's.
> > 
> > I'm a bit confused, the whole goal here is to give the thing a different name?
> 
> 
> Both the PR Decoupler and AXI Shutdown IP manager IP's are follows same register spec.
> Most of the code is common so we thought of reusing  same driver for AXI shutdown manager as well.

What are the differences, though other than it shows a different name?
> 
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/xilinx-pr-decoupler.c | 35
> > > ++++++++++++++++++++++++++----
> > >  1 file changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/fpga/xilinx-pr-decoupler.c
> > > b/drivers/fpga/xilinx-pr-decoupler.c
> > > index 7d69af230567..c95f3d065ccb 100644
> > > --- a/drivers/fpga/xilinx-pr-decoupler.c
> > > +++ b/drivers/fpga/xilinx-pr-decoupler.c
> > > @@ -19,10 +19,15 @@
> > >  #define CTRL_OFFSET		0
> > >
> > >  struct xlnx_pr_decoupler_data {
> > > +	const struct xlnx_config_data *ipconfig;
> > >  	void __iomem *io_base;
> > >  	struct clk *clk;
> > >  };
> > >
> > > +struct xlnx_config_data {
> > > +	char *name;
> > > +};
> > > +
> > >  static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data
> > *d,
> > >  					   u32 offset, u32 val)
> > >  {
> > > @@ -76,15 +81,28 @@ static const struct fpga_bridge_ops
> > xlnx_pr_decoupler_br_ops = {
> > >  	.enable_show = xlnx_pr_decoupler_enable_show,  };
> > >
> > > +static const struct xlnx_config_data decoupler_config = {
> > > +	.name = "Xilinx PR Decoupler",
> > > +};
> > > +
> > > +static const struct xlnx_config_data shutdown_config = {
> > > +	.name = "Xilinx DFX AXI shutdown mgr", };
> > 
> > If it's just the strings, why not store them as is?
> 
> In order to differentiate the IP's at probe time we are using this name filed.
> 
> > > +
> > >  static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
> > > -	{ .compatible = "xlnx,pr-decoupler-1.00", },
> > > -	{ .compatible = "xlnx,pr-decoupler", },
> > > +	{ .compatible = "xlnx,pr-decoupler-1.00", .data = &decoupler_config
> > },
> > > +	{ .compatible = "xlnx,pr-decoupler", .data = &decoupler_config },
> > > +	{ .compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
> > > +					.data = &shutdown_config },
> > > +	{ .compatible = "xlnx,dfx-axi-shutdown-manager",
> > > +					.data = &shutdown_config },
> > >  	{},
> > >  };
> > >  MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
> > >
> > >  static int xlnx_pr_decoupler_probe(struct platform_device *pdev)  {
> > > +	struct device_node *np = pdev->dev.of_node;
> > >  	struct xlnx_pr_decoupler_data *priv;
> > >  	struct fpga_bridge *br;
> > >  	int err;
> > > @@ -94,6 +112,14 @@ static int xlnx_pr_decoupler_probe(struct
> > platform_device *pdev)
> > >  	if (!priv)
> > >  		return -ENOMEM;
> > >
> > > +	if (np) {
> > > +		const struct of_device_id *match;
> > > +
> > > +		match = of_match_node(xlnx_pr_decoupler_of_match, np);
> > > +		if (match && match->data)
> > > +			priv->ipconfig = match->data;
> > > +	}
> > > +
> > >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
> > >  	if (IS_ERR(priv->io_base))
> > > @@ -114,7 +140,7 @@ static int xlnx_pr_decoupler_probe(struct
> > > platform_device *pdev)
> > >
> > >  	clk_disable(priv->clk);
> > >
> > > -	br = devm_fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
> > > +	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
> > >  				     &xlnx_pr_decoupler_br_ops, priv);
> > >  	if (!br) {
> > >  		err = -ENOMEM;
> > > @@ -125,7 +151,8 @@ static int xlnx_pr_decoupler_probe(struct
> > > platform_device *pdev)
> > >
> > >  	err = fpga_bridge_register(br);
> > >  	if (err) {
> > > -		dev_err(&pdev->dev, "unable to register Xilinx PR
> > Decoupler");
> > > +		dev_err(&pdev->dev, "unable to register %s",
> > > +			priv->ipconfig->name);
> > >  		goto err_clk;
> > >  	}
> > >
> > > --
> > > 2.18.0
> > >
> > 
> 
> Regards,
> Navakishore.
- Moritz
