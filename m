Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA785E7598
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIWITZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiIWITY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 04:19:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD9E12C1E8
        for <linux-fpga@vger.kernel.org>; Fri, 23 Sep 2022 01:19:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1obdtu-0008WU-3O; Fri, 23 Sep 2022 10:19:10 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1obdtt-0007PY-2R; Fri, 23 Sep 2022 10:19:09 +0200
Date:   Fri, 23 Sep 2022 10:19:09 +0200
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru
Subject: Re: [PATCH v12 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20220923081909.GO986@pengutronix.de>
References: <20220919134750.25197-1-i.bornyakov@metrotek.ru>
 <20220919134750.25197-2-i.bornyakov@metrotek.ru>
 <Yy1RLvxTJhGUuJJ2@yilunxu-OptiPlex-7050>
 <20220923071638.45hylqvajn74j6mk@h-e2.ddg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923071638.45hylqvajn74j6mk@h-e2.ddg>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Sep 23, 2022 at 10:16:38AM +0300, Ivan Bornyakov wrote:
> On Fri, Sep 23, 2022 at 02:24:46PM +0800, Xu Yilun wrote:
> > On 2022-09-19 at 16:47:49 +0300, Ivan Bornyakov wrote:
> > > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > > slave SPI sysCONFIG interface.
> > > 
> > > sysCONFIG interface core functionality is separate from both ECP5 and
> > > SPI specifics, so support for other FPGAs with different port types can
> > > be added in the future.
> > > 
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > ---
> > >  drivers/fpga/Kconfig                 |  11 +
> > >  drivers/fpga/Makefile                |   2 +
> > >  drivers/fpga/lattice-sysconfig-spi.c | 153 ++++++++++
> > >  drivers/fpga/lattice-sysconfig.c     | 408 +++++++++++++++++++++++++++
> > >  drivers/fpga/lattice-sysconfig.h     |  40 +++
> > >  5 files changed, 614 insertions(+)
> > >  create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
> > >  create mode 100644 drivers/fpga/lattice-sysconfig.c
> > >  create mode 100644 drivers/fpga/lattice-sysconfig.h
> > > 
> > > diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
> > > new file mode 100644
> > > index 000000000000..d015b796adf7
> > > --- /dev/null
> > > +++ b/drivers/fpga/lattice-sysconfig-spi.c
> > > 
> > > ... snip ...
> > > 
> > > +static int sysconfig_isc_enable(struct sysconfig_priv *priv)
> > > +{
> > > +	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
> > > +	u32 status;
> > > +	int ret;
> > > +
> > > +	ret = sysconfig_cmd_write(priv, isc_enable, sizeof(isc_enable));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = sysconfig_poll_status(priv, &status);
> > > +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> > > +		return ret ? : -EFAULT;
> > 
> > If (ret == 0 && status == SYSCONFIG_STATUS_FAIL), still return 0?
> > 
> 
> No, -EFAULT should be returned in that case. Am I overlooked something?

No, you don't, but writing this a bit less terse makes it far more
readable:

	ret = sysconfig_poll_status(priv, &status);
	if (ret)
		return ret;
	if (status & SYSCONFIG_STATUS_FAIL)
		return -EFAULT;

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
