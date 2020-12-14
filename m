Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E52DA32A
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 23:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgLNWQn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 17:16:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439416AbgLNWQ2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 17:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607984100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHuGEiYKbFkk3lBVoLQpk+cXrtoVinieQyxm24E1EQg=;
        b=TeXInRv3CsSnGUJVzAGDQIkh7NVQ9VUDvZIIqz/kxaI9xHrOcKgkXvcO8X9gnMsdjHujZv
        QTnTVYm8EThDSyMfj6Zxn/jgGkPZVtOkpcTyzrZ3OE5uxQcd2T/d/ah6ZaINl6MhiSsyJf
        GOMIPNftN5YIrZ71pJWUn1jHYw04YDg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-NCa2MNLJOpWFnjOJqxMSPQ-1; Mon, 14 Dec 2020 17:14:59 -0500
X-MC-Unique: NCa2MNLJOpWFnjOJqxMSPQ-1
Received: by mail-qt1-f200.google.com with SMTP id v9so12774230qtw.12
        for <linux-fpga@vger.kernel.org>; Mon, 14 Dec 2020 14:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GHuGEiYKbFkk3lBVoLQpk+cXrtoVinieQyxm24E1EQg=;
        b=jHYB7v4APILID0eZ9lkdFxFsjoy1gs3iOGxQKE/5JiI/dfOCYly4kRfY0TOQopG2XS
         DcMMU1g6acdE7oaIRVFcck1XKbw2Us8UTrwaDhBkafA4BATVHusJO4bUPiI0DQnEPgfW
         lzTcFvemwKqovvM7NQYlvCHc7saQp8hxtNJDepUyVnRrF/0msIPpPCB1MdX8w1sxhkVA
         vOChVsICIJ7Ko+SxKVjVEhjLUDSlQ+E8JY+chjehr8sXtWAGIlE/nCJLAAMM6JCRQEii
         og2BY1wE8+mSKWbY81ScigB36MP4W/hCIP1jbQN1FJK4vOXnbkW8OZWhRO//HRUd27Yt
         Wttw==
X-Gm-Message-State: AOAM530RMDIXuktsNukyf1heSTd/f10RRAFdwQwl8ZmlCAnoK7M4PYp6
        fsYJ8vVzh1Jvw5RpsCX+SEArZ1IHpyPDYMH2mWCF4uSKTA5zHUMizhn5OJzoodpmGy/LIkEqp1p
        /eENOtXzSwVgNfA/qauJJMQ==
X-Received: by 2002:a05:622a:110:: with SMTP id u16mr35261833qtw.181.1607984098989;
        Mon, 14 Dec 2020 14:14:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4PgKAVC5B00q7HgkgdfHdt5shtVU8RhnAknogo2AMo2JEa9ZY3uVp7zr58elLFt4pfmrMWA==
X-Received: by 2002:a05:622a:110:: with SMTP id u16mr35261810qtw.181.1607984098779;
        Mon, 14 Dec 2020 14:14:58 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u5sm15851512qka.106.2020.12.14.14.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:14:58 -0800 (PST)
Subject: Re: [PATCH v2 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
 <1607916981-14782-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4bbaa5ad-b0eb-8ea6-9dc6-c08060450e36@redhat.com>
Date:   Mon, 14 Dec 2020 14:14:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1607916981-14782-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/13/20 7:36 PM, Xu Yilun wrote:
> This patch adds description for UIO support for dfl devices on DFL
> bus.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> ---
>  Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
Should add your self in the authors list.
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6..a15e81e 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,6 +502,29 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
>  
> +UIO support for DFL devices
> +===========================
> +The FPGA is open for users to be reprogramed with newly developed hardware

The purpose of an FPGA is to be reprogrammed with newly developed hardware

components.  New hardware can

> +components. They could instantiate a new private feature in the DFL, and then
> +get a DFL device in their system. In some cases users may need a userspace
> +driver for the DFL device:
> +
> +* Users may need to run some diagnostic test for their hardwares.
* Users may prototype the kernel driver in user space.
> +* Some hardware is designed for specific purposes and does not fit into one of
> +  the standard kernel subsystems.
> +
> +This requires the direct access to the MMIO space and interrupt handling in
> +userspace. We implemented a dfl-uio-pdev module which exposes the UIO device
The dfl-uio-pdev module exposes
> +interfaces. It adds the uio_pdrv_genirq platform device with the resources of
> +the DFL device, and let the generic UIO platform device driver provide UIO
the DLF device, and lets
> +support to userspace.
Use FPGA_DFL_UIO_PDEV to enable this feature.
> +
> +The DFL UIO driver has a special matching algorithem. It will match any DFL
> +device which could not be handled by other DFL drivers. In this way, it will
> +not impact the functionality of the features which are already supported by the
> +system.
(not sure if this section is needed)

> +
> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration

