Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A784B77E8
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 21:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiBORhS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 12:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbiBORhR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 12:37:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E447040
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 09:37:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p9so12841940wra.12
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R0kZYuJZbdqjU2MhVLg6cTjo0WK3NRkG42w5SRhp0kg=;
        b=yYGXGlyznw09WQ/xKzvhgMUv6g3x7Sv9cBOqEdecKRX2B49o9XZ0lC4nzZHMFpTsOY
         B6tj2aG5sJpZGsjSXhWRoY8Rz+VoGQ75wFlWyq7b6k2LMxs4aJmO1Gt0SnKlK+0Dkwy/
         LLxKKB3WaGRpQjE3yO8iPqBSqjXXFdbbA7tluuHWi63Kk6cQ1UEQ3NZXQ7Cd0rvQSHFZ
         N+k2lpEAIpNSeItcDEH1qrJIKMBAgHfWEUN8wRN+L3G5BO2+VFXLBOUVejXt1iF+q1fu
         BAEhVgt5Jhuppf3sE2I1VXLJWyXm+pL2squPa0bR6MkL8Y+KtLLXVjNP5Gm+q0FtdpyS
         TK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R0kZYuJZbdqjU2MhVLg6cTjo0WK3NRkG42w5SRhp0kg=;
        b=4XRNFTQ9W6R/GVzGJ9q4DHZmC6fO/pNWnfay4QCv7I7fwVy2gATuQKLdOlxFY2/+7K
         rOoIyZ5VsitFi+BZ4KAqpopZ623w6pP2uNE4EDVoPNSRIqb0a5JUXgrv405lt1rILzq5
         x6CQRoRdC30FrpNcpXAcyeVSo1PQB6If/3PoWAgrGCjQneSPxV1FMLgr7ANE3qFsw2tE
         BKE3hHwKJA8EEWoo0Blc8NC/+xZt/FM+naoSFFsxbRLRH6VFZpJTVbvIryWkbzbpSDOb
         +4+hRj54x+4ukyDPKJhlhWQNQhLrliYlCy48e6QWF545qzqt2MZEuyJknlip3XmNPYfJ
         5EhA==
X-Gm-Message-State: AOAM532dvRSQoIzp22OCj3X9BsRIKhnWbJtcb2m76PF4K0GgFLLpW/BI
        J8e/eM/2cc8V6z/DU6A3R+Ib5g==
X-Google-Smtp-Source: ABdhPJxjxnqUSbTdPiQng/4gvFT/cwGHCZg9VbsXjdAqbOQc4UfWYES5Vs9Ns15Rh39Inoq2ILm2KA==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr57735wrs.644.1644946625283;
        Tue, 15 Feb 2022 09:37:05 -0800 (PST)
Received: from [192.168.2.116] ([109.78.72.167])
        by smtp.gmail.com with ESMTPSA id c9sm13422503wrn.51.2022.02.15.09.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:37:04 -0800 (PST)
Message-ID: <d0890e09-5d4a-5cce-832d-26e64b74ac54@conchuod.ie>
Date:   Tue, 15 Feb 2022 17:37:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] fpga: microsemi-spi: add Microsemi FPGA manager
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, system@metrotek.ru
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
 <20220215115853.26491-1-i.bornyakov@metrotek.ru>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220215115853.26491-1-i.bornyakov@metrotek.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hey Ivan,
Firstly thanks for the patch(es), stumbled across them today.
As you may know Microsemi has been acquired by Microchip, so
s/microsemi/microchip/ please. This would make the correct vendor
prefix for compatible strings "microchip". While you've said this is
for the PolarFire FPGA, there is prescendent for using "mpfs" for the
PolarFire SoC FPGA in the kernel - so if you could change the uses of
"polarfire" to "mpf" that'd be great.

The current item on my own todo list is the opposite side of this,
reprogramming the FPGA via the system controller acting as a SPI
master for PolarFire SoC.
I will get back to you when I have a better idea of what (if any) code
can be made generic between both modes. In the meantime, I will get
together a setup to test SPI slave reprogramming of the PolarFire (SoC)

Thanks,
Conor <conor.dooley@microchip.com>

 > Add support to the FPGA manager for programming Microsemi Polarfire
 > FPGAs over slave SPI interface.
 >
 > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
 > ---
 > Changelog:
 >   v1 -> v2: fix printk formating
 >
 >  drivers/fpga/Kconfig         |   9 +
 >  drivers/fpga/Makefile        |   1 +
 >  drivers/fpga/microsemi-spi.c | 366 +++++++++++++++++++++++++++++++++++
 >  3 files changed, 376 insertions(+)
 >  create mode 100644 drivers/fpga/microsemi-spi.c
 >
--<snip>--
