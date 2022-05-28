Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED2536C44
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiE1KK5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiE1KK4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 06:10:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE624FF3;
        Sat, 28 May 2022 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653732654; x=1685268654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rvv/1ikIsTltk1vVwBcc2RZ1C1BbsqEGEPXUWzW4f3w=;
  b=Z0J9HqPhH17NjYRyv8t+Mw5R9zw/0ufAtpQ3VNlZIjli7tQWNgYgW2Bd
   enL5cSu+X9C/PFS0n4tXa9LSsG49gH6FTziRUmIZMEwKcX7ZmtYHc4Hce
   N5A82LCJLXINXmryXD7A6/3U1cbbJveAYrvIScp+VWWXMulf+uC3YmQh+
   xclAwdhYLl2bxIUcmWemv1tGffN8f3Z9LEkv15+ryyXCoAPgSx2XDKYQY
   0i9CnpBRpl04Pma7tc9Q4qtJh5EuiUR+sFjL8zWLgpzAt5XDbjGdEy06M
   o2o4bBQ3NO8hv3lTJ/O4mQfGCDd+QGptgv4itWMOektU9cq0XXbPLbj6c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="300005768"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="300005768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 03:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="719230172"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2022 03:10:52 -0700
Date:   Sat, 28 May 2022 18:03:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     tien.sung.ang@intel.com, mdf@kernel.org, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Message-ID: <20220528100309.GD175008@yilunxu-OptiPlex-7050>
References: <20220518064844.2694651-1-tien.sung.ang@intel.com>
 <3911c8c7-da6d-e6f2-c747-3b601d9cdacc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3911c8c7-da6d-e6f2-c747-3b601d9cdacc@redhat.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 18, 2022 at 01:08:31PM -0700, Tom Rix wrote:
> 
> On 5/17/22 11:48 PM, tien.sung.ang@intel.com wrote:
> > From: Ang Tien Sung <tien.sung.ang@intel.com>
> > 
> > To support the error handling of a truncated bitstream sent.
> > The current AIB CvP firmware is not capable of handling a
> > data stream smaller than 4096bytes. The firmware's limitation
> > causes a hung-up as it's DMA engine waits forever for the
> > completion of the instructed 4096bytes.
> > To resolve this design limitation, both firmware and CvP
> > driver made several changes. At the CvP driver, we just
> > have to ensure that anything lesser than 4096bytes are
> > padded with extra bytes. The CvP will then, initiate the
> > tear-down by clearing the START_XFER and CVP_CONFIG bits.
> > We should also check for CVP_ERROR during the CvP completion.
> > A send_buf which is always 4096bytes is used to copy the
> > data during every transaction.
> > 
> > Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> > ---
> >   drivers/fpga/altera-cvp.c | 24 +++++++++++++++++++-----
> >   1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > index 4ffb9da537d8..80edcfb5e5fc 100644
> > --- a/drivers/fpga/altera-cvp.c
> > +++ b/drivers/fpga/altera-cvp.c
> > @@ -81,6 +81,7 @@ struct altera_cvp_conf {
> >   	u8			numclks;
> >   	u32			sent_packets;
> >   	u32			vsec_offset;
> > +	u8			*send_buf;
> 
> Why is it necessary to hold  the send_buf in this structure ?
> 
> If it is used only in *_write, could it alloc/freed there ?
> 
> Because the write happens rarely, my preference is to alloc/free in
> *_write().

Is it better alloc in write_init()?

Thanks,
Yilun

> 
> >   	const struct cvp_priv	*priv;
> >   };
> > @@ -453,7 +454,11 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
> >   		}
> >   		len = min(conf->priv->block_size, remaining);
> > -		altera_cvp_send_block(conf, data, len);
> > +		/* Copy the requested host data into the transmit buffer */
> > +
> > +		memcpy(conf->send_buf, data, len);
> Is a memset needed for a short buffer ?
> > +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> > +		conf->priv->block_size);
> >   		data += len / sizeof(u32);
> >   		done += len;
> >   		remaining -= len;
> > @@ -492,10 +497,13 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
> >   	if (ret)
> >   		return ret;
> > -	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
> > -	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
> > -	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
> > -		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
> > +	/*
> > +	 * STEP 16 - If bitstream error (truncated/miss-matched),
> > +	 * we shall exit here.
> > +	 */
> > +	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> Should this be STEP 17 ? the old 16 checked something else.
> 
> Tom
> 
> > +	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
> > +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");
> >   		return -EPROTO;
> >   	}
> > @@ -661,6 +669,12 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >   	pci_set_drvdata(pdev, mgr);
> > +	/* Allocate the 4096 block size transmit buffer */
> > +	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);
> > +	if (!conf->send_buf) {
> > +		ret = -ENOMEM;
> > +		goto err_unmap;
> > +	}
> >   	return 0;
> >   err_unmap:
