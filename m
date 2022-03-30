Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22D4EC95B
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Mar 2022 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbiC3QKb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Mar 2022 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiC3QKa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Mar 2022 12:10:30 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DA5FD0;
        Wed, 30 Mar 2022 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=AyXvDz2JAQhJmdGyyqbNeaM5gQrzmKCSgCcImXgLu2g=;
        b=Wk9BDT3XmGse2M76tPAWn/OTsT37I6coFW7g+iwCg0KaVZTGF/mDAI98HC9yK0itB2wsm161s0qSK
         Ra6Rc7RZRPQPGjwgoBxRcQ38+Lz7Cizb918JzjtQUUtEySIeNZYhpo+Y5my4IDQtfdCiJQaoynE4CA
         ubIvSIYIMBE1Jh5pfmcOWGnppHNTNXIK8Q/DbduIgXa42BOV4pwiK4VbufjAhSkEBsqkM/iWvcXQC+
         87mhCI7ngCtWGy4zaZbmSOvYY4vSkNR9wkQgkqCGfd/dgfyg7YJ3FU7awXFQJyp2hYlU/PkNbAGHDz
         dPChk5WUFRvHjv9ihhiEB1pqe5QVZAA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000009,0.020732)], BW: [Enabled, t: (0.000022,0.000002)], RTDA: [Enabled, t: (0.070240), Hit: No, Details: v2.31.0; Id: 15.52k0vh.1fvdpbdsn.1598; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 30 Mar 2022 19:08:12 +0300
Date:   Wed, 30 Mar 2022 18:48:31 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor.Dooley@microchip.com
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, Cyril.Jean@microchip.com
Subject: Re: [PATCH v8 1/2] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220330154831.kqqm7cymxa3reffk@x260>
References: <20220322191552.13156-1-i.bornyakov@metrotek.ru>
 <20220322191552.13156-2-i.bornyakov@metrotek.ru>
 <7fcde9aa-c086-33e1-1619-04663bfeff85@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fcde9aa-c086-33e1-1619-04663bfeff85@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi, Conor!

On Wed, Mar 30, 2022 at 02:37:05PM +0000, Conor.Dooley@microchip.com wrote:
> Hey Ivan,
> Been testing this and generated a couple questions.
> I've put them inline where they were relevant.
> Thanks,
> Conor.
> 
> On 22/03/2022 19:15, Ivan Bornyakov wrote:
> > 
> > ... snip ...
> > 
> > +static int mpf_ops_write_init(struct fpga_manager *mgr,
> > +                             struct fpga_image_info *info, const char *buf,
> > +                             size_t count)
> > +{
> > +       const u8 program_mode[] = { MPF_SPI_FRAME_INIT, MPF_SPI_PRG_MODE };
> > +       const u8 isc_en_command[] = { MPF_SPI_ISC_ENABLE };
> > +       struct mpf_priv *priv = mgr->priv;
> > +       struct device *dev = &mgr->dev;
> > +       struct spi_device *spi;
> > +       u32 isc_ret;
> > +       int ret;
> > +
> > +       if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > +               dev_err(dev, "Partial reconfiguration is not supported\n");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       spi = priv->spi;
> > +
> > +       ret = mpf_spi_write_then_read(spi, isc_en_command, sizeof(isc_en_command),
> > +                                     &isc_ret, sizeof(isc_ret));
> > +       if (ret || isc_ret) {
> > +               dev_err(dev, "Failed to enable ISC: %d\n", ret ? : isc_ret);
> > +               return -EFAULT;
> > +       }
> 
> So, my test board for this has had a PolarFire SoC, not a standard
> PolarFire. I ran into some problems with the ISC enable code, due to
> a sequence error. After sending the SPI_ISC_ENABLE, you then do a
> poll_status_not_busy to hold until you see a STATUS_READY.
> poll_status_not_busy does a w8r8 to request and then read the status,
> and you expect a sequence as below:
> 
> op:     w       w   r   w   r
> M:	0xB	0x0	0x0
> S:   		    0x1	    0x2
> 
> I could not get past this check & it would just poll until the
> timeout. What I saw on a protocol analyser was more like so:
> 
> op:     w       w   r    w   r
> M:	0xB	0x0      0x0
> S:   		0x1 0x0  0x2 0x0
> 
> So the read in that w8r8 would always get a zero back and then time out.
> Changing the poll function (just for isc) to only read gave:
> 
> op:     w       r       r
> M:	0xB	0x0	0x0
> S:   		0x1	0x2
> 
> For the code after the ISC enable, I reverted to your implementation
> of the poll function & the rest of the programming sequence ran.
> 
> I spoke to the guys that wrote the HW about this, and they said that
> reading the status back *as* the 0x0 the poll command is clocked in is
> the expected behaviour.
> They also said that MPF should work identically to an MPFS and I was unable
> to find a documented difference between MPF and MPFS other than the envm,
> which is an optional component anyway.
> 
> But I can only assume that what you were doing worked for you, so if
> you could possibly share some waveforms of the write_init sequence
> that'd be great. Or if there is something that you think I am
> overlooking, please let me know.
> 

If you replace poll_status_not_busy() function with this code:

static int poll_status_not_busy(struct spi_device *spi, u8 mask)
{
	u8 status, status_command = MPF_SPI_READ_STATUS;
	int ret, timeout = MPF_STATUS_POLL_TIMEOUT;
	struct spi_transfer xfer = {
		.tx_buf = &status_command,
		.rx_buf = &status,
		.len = 1,
	};

	while (timeout--) {
		ret = spi_sync_transfer(spi, &xfer, 1);
		if (ret < 0)
			return ret;

		if (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask)))
			return status;

		usleep_range(1000, 2000);
	}

	return -EBUSY;
}

Will it work for you? It is still works in my case.

> > 
> > ... snip ...
> > 
> > +static ssize_t parse_bitstream_size(struct sg_table *sgt)
> > +{
> > +       size_t component_size_byte_num, component_size_byte_off,
> > +              i, bitstream_size = 0;
> > +       ssize_t components_size_start;
> > +       u16 components_num;
> > +       u32 component_size;
> > +       int ret;
> > +
> > +       ret = get_sgt_data(sgt, MPF_DATA_SIZE_OFFSET, &components_num,
> > +                          sizeof(components_num));
> > +       if (ret)
> > +               return ret;
> > +
> > +       components_num = le16_to_cpu(components_num);
> 
> Not expecting you to do this at all since you don't have one, but this
> will need to be extended for polarfire soc since components_* doesn't
> include the envm which has its own parameter.
> 
> > +
> > +       components_size_start = lookup_block_start(sgt, MPF_COMPONENTS_SIZE_ID);
> > +       if (components_size_start < 0)
> > +               return components_size_start;
> > +
> > +       for (i = 0; i < components_num; i++) {
> > +               component_size_byte_num =
> > +                       (i * MPF_BITS_PER_COMPONENT_SIZE) / BITS_PER_BYTE;
> > +               component_size_byte_off =
> > +                       (i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
> > +
> > +               ret = get_sgt_data(sgt, components_size_start +
> > +                                  component_size_byte_num,
> > +                                  &component_size, sizeof(component_size));
> > +               if (ret)
> > +                       return ret;
> > +
> > +               component_size = le32_to_cpu(component_size);
> > +               component_size >>= component_size_byte_off;
> > +               component_size &= GENMASK(MPF_BITS_PER_COMPONENT_SIZE - 1, 0);
> > +
> > +               bitstream_size += component_size;
> > +       }
> > +
> > +       return bitstream_size;
> > +}
> > 
> > ... snip ...
> > 
> > +static int mpf_ops_write_complete(struct fpga_manager *mgr,
> > +                                 struct fpga_image_info *info)
> > +{
> > +       const u8 isc_dis_command[] = { MPF_SPI_ISC_DISABLE };
> > +       const u8 release_command[] = { MPF_SPI_RELEASE };
> > +       struct mpf_priv *priv = mgr->priv;
> > +       struct device *dev = &mgr->dev;
> > +       struct spi_device *spi;
> > +       int ret;
> > +
> > +       spi = priv->spi;
> > +
> > +       ret = mpf_spi_write(spi, isc_dis_command, sizeof(isc_dis_command));
> > +       if (ret) {
> > +               dev_err(dev, "Failed to disable ISC: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       usleep_range(1000, 2000);
> > +
> > +       ret = mpf_spi_write(spi, release_command, sizeof(release_command));
> > +       if (ret) {
> > +               dev_err(dev, "Failed to exit program mode: %d\n", ret);
> > +               return ret;
> > +       }
> 
> While I was debugging the sequence issue, it got to this stage of the
> transfer several times, but hadn't actually programmed the device.
> It seems that poll_status_not_busy covers checking ERR/VIOLATION from
> polling the status, but again that check is avoided due to the
> sequence issues I mentioned above.
> 
> It might be nice to check the device certificate, but I am not sure
> if that fits the flow for fpga managers.
> 

Noted.


