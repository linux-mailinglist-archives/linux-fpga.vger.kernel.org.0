Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2510557219D
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Jul 2022 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiGLROj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Jul 2022 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiGLROi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Jul 2022 13:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFB8E2ED59
        for <linux-fpga@vger.kernel.org>; Tue, 12 Jul 2022 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657646076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LWoZxmGBMuZPprfyc1QWNTPJ/dMjvswUT54ENVWGNc=;
        b=e6kNfcMiuRdTCbg/o4xAgrtzb4OGP4hwN+wxOWoRV09MQhCuSMv3VxezevOLjArLFGoM+b
        38GjihZqp9v6EAtIGw9SI9tixW1XVFOuyZOhtUaHIHwX4fphqSAO2LfeULnTrUA0X3D4up
        /61pmjTA0I3GDoAs4GosZjMk/9UkqiQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-o4CsU_uGNw-EQ28pqd0-dw-1; Tue, 12 Jul 2022 13:14:35 -0400
X-MC-Unique: o4CsU_uGNw-EQ28pqd0-dw-1
Received: by mail-wr1-f71.google.com with SMTP id l11-20020adfbd8b000000b0021d754b84c5so1599825wrh.17
        for <linux-fpga@vger.kernel.org>; Tue, 12 Jul 2022 10:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=6LWoZxmGBMuZPprfyc1QWNTPJ/dMjvswUT54ENVWGNc=;
        b=wRJOEfNabwZKB9VuuxoxDt79mxNChPYOUu3koMM9Pez8wzD2eHYID7ea2LG3CY58+c
         xRFx8V/qGeYCkYYNztDzPK+vzcP25LZOmG8YeHF1iADbjJKuxsbu2PtibXqBI5Dkq5zy
         Sxg2MPaLSPm/DbD3jG4SuDCSzav1i3i76ehqpP8oBlRDUE9cSNf7B0y7bSXF664cumrC
         eM/4fyjXCS55SVjNrFfPhYU2QlxdlC9fKyHkL+jc0bVJT/Fk58H14Flew7Utv8kg3GYb
         cG8oXSKrQcBe/GieJcTZbGZbrJ0TfLz5u4EqdEqy273shNfDrg09fqVH4Yzr88k9+Gm8
         XAig==
X-Gm-Message-State: AJIora8yNouFGTHY+obORUuIQm5iY6yIwdNjZ3KYkFMVDYvDZzPJFN7Y
        vcjz0mtkGZhbFY6TPaKm79UDoFKyFpkopKbCrz5kwL1krpyEwxU0j78hlZIDoeixmyop4G4Bpj8
        ISBXiiSNg2Ah9ktQ/R/HA
X-Received: by 2002:a5d:6d0e:0:b0:21d:6d4c:e0e4 with SMTP id e14-20020a5d6d0e000000b0021d6d4ce0e4mr24192067wrq.355.1657646074540;
        Tue, 12 Jul 2022 10:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v2F0cZX1TI83MjeQF5zCeIy2jw6sxxjhgQt61Lv57WOfETN0CAXdHA7iZyl7plmECX4COjcA==
X-Received: by 2002:a5d:6d0e:0:b0:21d:6d4c:e0e4 with SMTP id e14-20020a5d6d0e000000b0021d6d4ce0e4mr24192032wrq.355.1657646074266;
        Tue, 12 Jul 2022 10:14:34 -0700 (PDT)
Received: from [192.168.9.27] (net-2-34-30-100.cust.vodafonedsl.it. [2.34.30.100])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe786000000b0021b9504cc83sm8788767wrm.31.2022.07.12.10.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 10:14:33 -0700 (PDT)
Message-ID: <1aec7d55-24d5-e9bc-9052-728335ec7d9d@redhat.com>
Date:   Tue, 12 Jul 2022 19:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     matthew.gerlach@linux.intel.com
Cc:     basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        hao.wu@intel.com, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
References: <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-07-07 17:05, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add documentation on identifying FPGA based PCI cards prompted
> by discussion on the linux-fpga@vger.kernel.org mailing list.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3: Add url to page tracking PCI ID information for DFL based cards.
> 
> v2: Introduced in v2.
> ---
>  Documentation/fpga/dfl.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..5144775b860a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -507,6 +507,27 @@ ids application.
>  https://github.com/OPAE/dfl-feature-id
>  
>  
> +PCI Device Identification
> +================================
> +Since FPGA based PCI cards can be reconfigured to a perform a completely

There's a small typo: "to a perform" --> "to perform"

> +new function at runtime, properly identifying such cards and binding the
> +correct driver can be challenging. In many use cases, deployed FPGA based
> +PCI cards are essentially static and the PCI Product ID and Vendor ID pair
> +is sufficient to identify the card.  The DFL framework helps with the
> +dynamic case of deployed FPGA cards changing at run time by providing
> +more detailed information about card discoverable at runtime.
> +
> +At one level, the DFL on a PCI card describes the function of the card.
> +However, the same DFL could be instantiated on different physical cards.
> +Conversely, different DFLs could be instantiated on the same physical card.
> +Practical management of a cloud containing a heterogeneous set of such cards
> +requires a PCI level of card identification. While the PCI Product ID and
> +Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
> +that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
> +Vendor ID values. Further PCI Product, Vendor, and Subsystem id tracking
> +can be found at https://github.com/OPAE/dfl-feature-id/blob/main/dfl-pci-ids.rst.
> +
> +
>  Location of DFLs on a PCI Device
>  ================================
>  The original method for finding a DFL on a PCI device assumed the start of the

Marco

