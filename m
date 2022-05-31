Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2756B539320
	for <lists+linux-fpga@lfdr.de>; Tue, 31 May 2022 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbiEaOYO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 May 2022 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiEaOYM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 May 2022 10:24:12 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157978020A;
        Tue, 31 May 2022 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=J8M8YGaMefHW0AkjWLNXVgXcmOvL6c5NpOJNy13U8SQ=;
        b=TwsKZAcMfsw0dFg/O/U99HLXqXQq9VkRXI37vXdvrKA98ORvu9PInhGuyZk+cIZVygLWjLAHM3N3l
         MnJer1wvhJUhvi4fBv6KsDsJFHNXsDr98h8tqnWNwraMkSJcNRkJhY0L8WzoZN/2QRuhpzTp3S+0iU
         IRV+WBugKbquFlXtDcTzvtTraxtlbk1m7psgFDrfXzOI4GfzlMwfJB2Vnv6k7icIpZuakhZ3LVudhd
         M8UmHn6KvD200jKTHWNFRhKAFeg258ZEXRsD/YzfJf2liWdGI2G4XB+lRgMJup+N/VqrA0DLWR230m
         JPBRN2a2+VW1JQZ03G6k3mS2MS3p0dA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.030747)], BW: [Enabled, t: (0.000013,0.000001)], RTDA: [Enabled, t: (0.077851), Hit: No, Details: v2.39.0; Id: 15.52kerb.1g4d80gac.6c0f; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 31 May 2022 17:23:38 +0300
Date:   Tue, 31 May 2022 17:01:22 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor.Dooley@microchip.com
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220531140122.teiuoqwo2zmly6kh@x260>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <f655cf2f-555c-6480-a461-bcddb9e510f3@microchip.com>
 <20220530120701.sedwn3qeohlnj52e@x260>
 <95c44458-aeff-e356-1e32-c8f735570c3a@microchip.com>
 <3b6867a8-d4ce-c5f3-71d4-bd9c3c88c389@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b6867a8-d4ce-c5f3-71d4-bd9c3c88c389@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 31, 2022 at 10:53:07AM +0000, Conor.Dooley@microchip.com wrote:
> One last item, sorry!
> 
> On 30/05/2022 15:24, Conor Dooley wrote:
> > On 30/05/2022 13:07, Ivan Bornyakov wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> On Mon, May 30, 2022 at 11:22:26AM +0000, Conor.Dooley@microchip.com wrote:
> >>> On 26/05/2022 19:13, Ivan Bornyakov wrote:
> >>>> +static int mpf_read_status(struct spi_device *spi)
> >>>> +{
> >>>> +       u8 status = 0, status_command = MPF_SPI_READ_STATUS;
> >>>> +       /*
> >>>> +        * Two identical SPI transfers are used for status reading.
> >>>> +        * The reason is that the first one can be inadequate.
> >>>> +        * We ignore it completely and use the second one.
> >>>> +        */
> >>>> +       struct spi_transfer xfers[] = {
> >>>> +               [0 ... 1] = {
> >>>> +                       .tx_buf = &status_command,
> >>>> +                       .rx_buf = &status,
> >>>> +                       .len = 1,
> >>>> +                       .cs_change = 1,
> 
> Should cs_change be set for both messages or just the first?
>  From reading the documentation, it looks like we only want it
> for the first one.
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/spi/spi.h#L895
> 
> Thanks,
> Conor.
> 

You're right, I've overlooked that moment.

> >>>> +               }
> >>>> +       };
> >>>
> >>> Hmm, I don't think that this is correct, or at least it is not
> >>> correct from the polarfire /soc/ perspective. I was told that
> >>> there was nothing different other than the envm between the
> >>> programming for both devices - but this is another situation
> >>> where I start to question that.
> >>>
> >>> When I run this code, ISC enable /never/ passes - failing due
> >>> to timing out. I see something like this picture here:
> >>> https://i.imgur.com/EKhd1S3.png
> >>> You can see the 0x0B ISC enable coming through & then a status
> >>> check after it.
> >>>
> >>> With the current code, the value of the "status" variable will
> >>> be 0x0, given you are overwriting the first MISO value with the
> >>> second. According to the hw guys, the spi hw status *should*
> >>> only be returned on MISO in the first byte after SS goes low.
> >>>
> >>> If this is not the case for a non -soc part, which, as I said
> >>> before, I don't have a board with the SPI programmer exposed
> >>> for & I have been told is not the case then my comments can
> >>> just be ignored entirely & I'll have some head scratching to
> >>> do...
> >>>
> >>> Thanks,
> >>> Conor.
> >>>
> >>
> >> If I understood correctly, SS doesn't alter between two status reading
> >> transactions despite .cs_change = 1. May be adding some .cs_change_delay
> >> to spi_transfer struct can help with that?
> > 
> > D-oh - bug in the spi controller driver :)
> > LGTM now, successfully programmed my PolarFire SoC with v12.
> > I'd almost suggest adding a compatible for it too - but since
> > the envm programming doesn't work I don't think that would be
> > correct.
> > 
> > Tested-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> > With a small comment about why it's using spi_sync_transfer():
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> >>
> >>>> +       int ret = spi_sync_transfer(spi, xfers, 2);
> >>>> +
> >>>> +       if ((status & MPF_STATUS_SPI_VIOLATION) ||
> >>>> +           (status & MPF_STATUS_SPI_ERROR))
> >>>> +               ret = -EIO;
> >>>> +
> >>>> +       return ret ? : status;
> >>>> +}
> >>
> > 
> 

