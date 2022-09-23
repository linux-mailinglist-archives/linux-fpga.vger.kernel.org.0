Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08705E74BF
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 09:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIWHSV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIWHSL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 03:18:11 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18412A491;
        Fri, 23 Sep 2022 00:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=7MHHrAv1OwxssOXzvupGEUun9sAM86TYBq9qQ1+Tdw8=;
        b=KNTDClVTuuPzxrmkvHfn816eBllecM3dLRlPX+XqxGjV3Q/lp+MA3ObQDMr18BJo0dFba+uytgp1W
         BkAB+ANTD9+gHW5sQCaKx2M3ib94BRXN3pzPSBzwUioYHF5LkeZ8eoXt8FjXROCP0HizR3vkFKyLyd
         bqy1e36MCjrooQlcNYD0QGQXFdZx3m1FS+khtHi8Dc1xQrDeVIzq9boVQpLG8i54fPYd0ax4Cg4PEa
         okZxpRnNhwIuK2xZwsZl3MbblrlQCVatoFrN0JHRyAyvSpffYKu7R0hRGxNvKhQe2LZNo3zQCtDLTp
         rEJjnBOSp8L0dA88RAFoOMnGlZ2zaBg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.011158)], BW: [Enabled, t: (0.000026,0.000002)], RTDA: [Enabled, t: (0.073971), Hit: No, Details: v2.41.0; Id: 15.52k92n.1gdkjbn07.1hek; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 23 Sep 2022 10:17:59 +0300
Date:   Fri, 23 Sep 2022 10:16:38 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v12 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20220923071638.45hylqvajn74j6mk@h-e2.ddg>
References: <20220919134750.25197-1-i.bornyakov@metrotek.ru>
 <20220919134750.25197-2-i.bornyakov@metrotek.ru>
 <Yy1RLvxTJhGUuJJ2@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy1RLvxTJhGUuJJ2@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Sep 23, 2022 at 02:24:46PM +0800, Xu Yilun wrote:
> On 2022-09-19 at 16:47:49 +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > slave SPI sysCONFIG interface.
> > 
> > sysCONFIG interface core functionality is separate from both ECP5 and
> > SPI specifics, so support for other FPGAs with different port types can
> > be added in the future.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >  drivers/fpga/Kconfig                 |  11 +
> >  drivers/fpga/Makefile                |   2 +
> >  drivers/fpga/lattice-sysconfig-spi.c | 153 ++++++++++
> >  drivers/fpga/lattice-sysconfig.c     | 408 +++++++++++++++++++++++++++
> >  drivers/fpga/lattice-sysconfig.h     |  40 +++
> >  5 files changed, 614 insertions(+)
> >  create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
> >  create mode 100644 drivers/fpga/lattice-sysconfig.c
> >  create mode 100644 drivers/fpga/lattice-sysconfig.h
> > 
> > diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
> > new file mode 100644
> > index 000000000000..d015b796adf7
> > --- /dev/null
> > +++ b/drivers/fpga/lattice-sysconfig-spi.c
> > 
> > ... snip ...
> > 
> > +static int sysconfig_isc_enable(struct sysconfig_priv *priv)
> > +{
> > +	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
> > +	u32 status;
> > +	int ret;
> > +
> > +	ret = sysconfig_cmd_write(priv, isc_enable, sizeof(isc_enable));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = sysconfig_poll_status(priv, &status);
> > +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> > +		return ret ? : -EFAULT;
> 
> If (ret == 0 && status == SYSCONFIG_STATUS_FAIL), still return 0?
> 

No, -EFAULT should be returned in that case. Am I overlooked something?

> > +
> > +	return 0;
> > +}
> > +
> > +static int sysconfig_isc_erase(struct sysconfig_priv *priv)
> > +{
> > +	u8 isc_erase[] = SYSCONFIG_ISC_ERASE;
> > +	u32 status;
> > +	int ret;
> > +
> > +	ret = sysconfig_cmd_write(priv, isc_erase, sizeof(isc_erase));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = sysconfig_poll_status(priv, &status);
> > +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> 
> Same concern.
> 
> > +		return ret ? : -EFAULT;
> > +
> > +	return 0;
> > +}

