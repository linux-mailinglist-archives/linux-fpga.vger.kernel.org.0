Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB26AAB62
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Mar 2023 18:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCDRCC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 4 Mar 2023 12:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDRCB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 4 Mar 2023 12:02:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16F1E2B2;
        Sat,  4 Mar 2023 09:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42FF2B8085B;
        Sat,  4 Mar 2023 17:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FEC433EF;
        Sat,  4 Mar 2023 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677949318;
        bh=57oPXRjQ+3tAP3ItxEgo1dN1/TWnvl0SjzZfl9niEcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlLX4+RKCzHM8WJjTRz/pa270WCZvESldBVgdFhdmzvE2CREodYlbM9TnKLCGrPJh
         OQZ5apM8tCI98VKofbJtsu0X2l8/BFyRgpmtqAVqtbgDj4jZoOaa6+98v2EtyQ2IV8
         WKOpIELXS2pIV/siBUttUXAqiP2YiZ7ysxlvZVg/Fw41N5zTZ+G36W/n8JD9aVx8UI
         AIqNpVJHO8Qr1MDCVRMhficer/m2EsdtOmcZTM8Dppmv/+gi7guzL6BnqhjNaWArR6
         eQfqIOOdOSDdtpSlaUJfusu49EhrTA3exXj6RKnua1v7F35nhns0ZRKHY8OXMxjKEm
         qqApq9NmTSX5A==
Date:   Sat, 4 Mar 2023 17:01:53 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v1 5/6] fpga: add PolarFire SoC Auto Update support
Message-ID: <59750d1a-de31-4e89-b8a9-d97ef66aa5f6@spud>
References: <20230217164023.14255-1-conor@kernel.org>
 <20230217164023.14255-6-conor@kernel.org>
 <ZANz6NLgSja2pfYa@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OcVmO8cg0uVjSPRD"
Content-Disposition: inline
In-Reply-To: <ZANz6NLgSja2pfYa@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--OcVmO8cg0uVjSPRD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2023 at 12:38:00AM +0800, Xu Yilun wrote:
> On 2023-02-17 at 16:40:22 +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Add support for Auto Update reprogramming of the FPGA fabric on
> > PolarFire SoC.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  drivers/fpga/Kconfig                 |   9 +
> >  drivers/fpga/Makefile                |   1 +
> >  drivers/fpga/microchip-auto-update.c | 495 +++++++++++++++++++++++++++
> >  3 files changed, 505 insertions(+)
> >  create mode 100644 drivers/fpga/microchip-auto-update.c
> > +	/*
> > +	 * To verify that Auto Update is possible, the "Query Security Service

> Why verify the possibility here, if Auto Update is not possible, the
> Auto Update device should not be populated, is it?

Good point, I'll check this in probe instead.

> > +	/*
> > +	 * Populate the image address and then zero out the next directory so
> > +	 * that the system controller doesn't complain if in "Single Image"
> > +	 * mode.
> > +	 */
> > +	memcpy(buffer + AUTO_UPDATE_UPGRADE_DIRECTORY, &image_address, AUTO_U=
PDATE_DIRECTORY_WIDTH);
> > +	memset(buffer + AUTO_UPDATE_BLANK_DIRECTORY, 0x0, AUTO_UPDATE_DIRECTO=
RY_WIDTH);
>=20
> I'm wondering why the image address should be written for every
> updating? Seems it is only related to the flash size, not related to
> the to-be-programmed bitstream.

Yah, it doesn't need to be. I'll check it against the expected value &
only write it if needed.

> > +	dev_info(priv->dev, "Running verification of Upgrade Image\n");
> > +	ret =3D mpfs_blocking_transaction(priv->sys_controller, message);
> > +	if (ret | response->resp_status) {
> > +		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
> > +		ret =3D ret ? ret : -EBADMSG;
>=20
> If verification failed, what happens to the written flash? Auto roll
> back?

Nope, that should be left up to userspace to decide what to do. I've got
some improvement to do to the mailbox driver that sits behind
mpfs_blocking_transaction() that I thought was not allowed by the
mailbox framework, so should be able to report better errors for this in
the future.

> > +	}
> > +
> > +	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
> > +//	/*
> > +//	 * If the validation has passed, initiate Auto Update.
> > +//	 * This service has no command data and no response data. It overlo=
ads
> > +//	 * mbox_offset with the image index in the flash's SPI directory wh=
ere
> > +//	 * the bitstream is located.
> > +//	 * Once we attempt Auto Update either:
> > +//	 * - it passes and the board reboots
> > +//	 * - it fails and the board reboots to recover
> > +//	 * - the system controller aborts and we exit "gracefully".
> > +//	 *   "gracefully" since there is no interrupt produced & it just ti=
mes
> > +//	 *   out.
> > +//	 */
> > +//	response->resp_msg =3D response_msg;
> > +//	response->resp_size =3D AUTO_UPDATE_PROGRAM_RESP_SIZE;
> > +//	message->cmd_opcode =3D AUTO_UPDATE_PROGRAM_CMD_OPCODE;
> > +//	message->cmd_data_size =3D AUTO_UPDATE_PROGRAM_CMD_DATA_SIZE;
> > +//	message->response =3D response;
> > +//	message->cmd_data =3D AUTO_UPDATE_PROGRAM_CMD_DATA;
> > +//	message->mbox_offset =3D 0; //field is ignored
> > +//	message->resp_offset =3D AUTO_UPDATE_DEFAULT_RESP_OFFSET;
> > +//
> > +//	dev_info(priv->dev, "Running Auto Update command\n");
> > +//	ret =3D mpfs_blocking_transaction(priv->sys_controller, message);
> > +//	if (ret && ret !=3D -ETIMEDOUT)
> > +//		goto out;
> > +//
> > +//	/* *remove this for auto update*
> > +//	 * This return 0 is dead code. Either the Auto Update will fail, or=
 it will pass
> > +//	 * & the FPGA will be rebooted in which case mpfs_blocking_transact=
ion()
> > +//	 * will never return and Linux will die.
> > +//	 */
> > +//	return 0;
>=20
> Why comment out this code block?

It was meant to be removed & must have snuck back in a rebase. This is my
test code that initiates the update from Linux, rather than at reboot.

I'm going to take a look at Russ' driver before I submit another version
of this (and the underlying mailbox stuff also needs changes).

Thanks for taking a look,
Conor.

--OcVmO8cg0uVjSPRD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAN5gAAKCRB4tDGHoIJi
0g2nAP9j2ObA+tq/YlDOio7Uggfuittp658IFX8AuugEjpWtBgD/eDXvX76aNYQ8
kMbqt6dnVaIEKqVvQ7SWtwvceu+1nQw=
=pvCA
-----END PGP SIGNATURE-----

--OcVmO8cg0uVjSPRD--
