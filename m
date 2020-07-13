Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC821D8AA
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Jul 2020 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgGMOgc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Jul 2020 10:36:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24522 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729681AbgGMOgc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Jul 2020 10:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594650991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utDsxiJbHEkm2Fob90PfdlUV1I68F8zwYkv/4x3NbvE=;
        b=Z9nkb3sv/6SfKD1iioN/w6ugrRbxyP8xTZurh4Iyc53k2OJaBqkZC3SvSITvzspq7vOOMb
        1AbL7lq7n1QhPjJCD6kDfG6JJZElKQWynUTNPg4jThXiKXOvkvobM6ltrE5OkO/MJCX13d
        KmsoA0ZR3ncOm+HYRH+WzVO/JKMoV2A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-yN4MofmoOJiTOecFqY429Q-1; Mon, 13 Jul 2020 10:36:29 -0400
X-MC-Unique: yN4MofmoOJiTOecFqY429Q-1
Received: by mail-qt1-f200.google.com with SMTP id q7so10274162qtq.14
        for <linux-fpga@vger.kernel.org>; Mon, 13 Jul 2020 07:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=utDsxiJbHEkm2Fob90PfdlUV1I68F8zwYkv/4x3NbvE=;
        b=D3SvQ3n705uTwHkwxXfSEeM8RGiBuG1x7qz9oid2J0W86V3gzve8mGZc4GVDO19PbC
         Ma2bE9uIKsaVDSzUcnjGeunB6muOlWNeuq2++tuwdZNq5SedQbGelfRKIj3jrtGfgGtj
         Mx0CY3iCVpYs3DtnUr/OvOFutlZ3HFTJJqU+S9/ax7NapOOrelSDIKt5EkUf/+DZ/c8i
         fjUqD1AxCKMvmPjyrCV7WH0Q2NOqvMGskHt3TR6IDEV1cDSYARDR5e28GkZ4O45NpHhm
         tnMg1CC2IctDB19topBWo50BxWt+bUx7HpF02CA3mbG7ofpd1eh4YdnkBG+/zuNpFnvk
         d0JQ==
X-Gm-Message-State: AOAM5331VLzVpabZH86pEi/tR5N8v5Ig5Dv2XgjkJvLfxHcFHDHBO6QT
        bnguwiRB6ncqlzNRAVVnLVtb5/5XaPuHWIesj8s5nJjSbcMdM6JRJKFZ+Imy1nNatrHbfLhi+ai
        RE1MG4G4CJswmedjNz6kflQ==
X-Received: by 2002:a37:6503:: with SMTP id z3mr78457622qkb.439.1594650989243;
        Mon, 13 Jul 2020 07:36:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyntha6qH4OqLYs+Aw/+Ul63oVHCE5s/a6MbC4bAbOEfy0jDN0mdDBf5bhWChHo+7pbRt1Y/Q==
X-Received: by 2002:a37:6503:: with SMTP id z3mr78457606qkb.439.1594650989040;
        Mon, 13 Jul 2020 07:36:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k6sm17845686qki.123.2020.07.13.07.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 07:36:28 -0700 (PDT)
Subject: Re: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4efe6ee9-4e88-5b31-01a2-414f752a3d2e@redhat.com>
Date:   Mon, 13 Jul 2020 07:36:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> +#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30

My point about consistency.  These are all intel  and all should have their pf parts removed.

 #define PCIE_DEVICE_ID_INTEL_INT_5_X	0xBCBD
 #define PCIE_DEVICE_ID_INTEL_INT_6_X	0xBCC0
 #define PCIE_DEVICE_ID_INTEL_DSC_1_X	0x09C4

Let's revisit this for the d5005.

trix


