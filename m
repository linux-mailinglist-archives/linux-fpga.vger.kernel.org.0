Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9F2B2E3F
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Nov 2020 16:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKNPyB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Nov 2020 10:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbgKNPyB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 14 Nov 2020 10:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605369239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdylbP2NfyT0+ghuXLqODU9fXbydrot5yDDVn5EPhdA=;
        b=KaAgVvXtTzDEsDj3VDMOSHtH28uhnRMqn0oIOCo+CRg7WGfk/c+0mWQQ6Xu6F2hmvuVR1/
        P/jwm7gldxJasH93OxuZQTqpaqz5jKpkkOzZ+D2/OOGKhv6xU7tld8RsamX7PpAMSIX3d6
        43gxvEMPgbF8Zye4PvZQkUt0Hq/ICBA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-z9N5RynYOyG6PD85hPl5GA-1; Sat, 14 Nov 2020 10:53:57 -0500
X-MC-Unique: z9N5RynYOyG6PD85hPl5GA-1
Received: by mail-qv1-f72.google.com with SMTP id y21so197880qve.7
        for <linux-fpga@vger.kernel.org>; Sat, 14 Nov 2020 07:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WdylbP2NfyT0+ghuXLqODU9fXbydrot5yDDVn5EPhdA=;
        b=Okxg9uowLExAcipaVVC4poUapgOY9AYBuzopKJuq9sao4dOoGKRywVoN7JaUZvQRXY
         W2Lq803G2gIEBouAp+duruHEwPqHv/BIspsaQADJbJuQ+aY1rrIy1btsMKQmVAj5j3Oa
         m/2+SaEjQsgyi091lecj86Xav975Yj7HAjvWtUEvV9bqecJk4nOI9bddoY9FtG4Zes0U
         LPfMDgwLSzQp94sQZi85yUTKWXXnWeej6jHzxaOB0kZ4FcfSJHBR8FOhEj76YPfrurtq
         usVve1vnPDLjFkDMmtx2wgc2CdBEzo3nCre5sgHdU8ZnGDjjhcSAGon5ZeRcEgthXjun
         cUgQ==
X-Gm-Message-State: AOAM531kyqudojUFzcuhf47C3a5v7YmN9+xxPcfUPQiLNqLcuJWX21p7
        eXZcGyIf/dv6kPyYn4M+/1tQkE3dQGX9WSaR6fqy7QLo76nzoVMALuRDoru1Py3jGrPIyjv3bh+
        bNrdRKStuKIuzpcML9RnfHQ==
X-Received: by 2002:a37:e12:: with SMTP id 18mr4265874qko.179.1605369237482;
        Sat, 14 Nov 2020 07:53:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4r1WeR6yUrgT85N7nd2d0YiKq5XInRkccXpaBEvTZ7tazPNx+ZgS7E0GahK+l8SJ4hcyh8g==
X-Received: by 2002:a37:e12:: with SMTP id 18mr4265861qko.179.1605369237249;
        Sat, 14 Nov 2020 07:53:57 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c199sm506723qke.111.2020.11.14.07.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 07:53:56 -0800 (PST)
Subject: Re: [PATCHv1 1/4] fpga: fpga-mgr: add
 FPGA_MGR_BITSTREM_AUTHENTICATION flag
To:     Richard Gong <richard.gong@linux.intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-2-git-send-email-richard.gong@linux.intel.com>
 <a71b7a9c-effa-ad01-4fde-3e1a1e517e2d@redhat.com>
 <4dd9a747-05f3-1cca-22a6-35681677223d@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <28d2ace8-315a-3eaf-75da-88a4e90ea045@redhat.com>
Date:   Sat, 14 Nov 2020 07:53:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4dd9a747-05f3-1cca-22a6-35681677223d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/14/20 6:30 AM, Richard Gong wrote:
>
>> A whitespace issue, the new BIT(5) should align with the others, so add two spaces to the others.
>>
>
> There is only one space, also I ran checkpatch with strict option and didn't see any whitespace issue.
>
> In the original patch, BIT(0) to BIT(4) align themselves. I am not sure why we see differently in email.
>
>  #define FPGA_MGR_PARTIAL_RECONFIG      BIT(0)
>  #define FPGA_MGR_EXTERNAL_CONFIG       BIT(1)
>  #define FPGA_MGR_ENCRYPTED_BITSTREAM   BIT(2)
>  #define FPGA_MGR_BITSTREAM_LSB_FIRST   BIT(3)
>  #define FPGA_MGR_COMPRESSED_BITSTREAM  BIT(4)
> +#define FPGA_MGR_BITSTREM_AUTHENTICATION BIT(5)
>
> To align BIT(5) with others, I have to use additional tab to BIT(0) to BIT(4). But I don't think I should make such change on them, agree?

The existing table of #defines has aligned values for BIT(0) to BIT(4)

Your addition of BIT(5) value has an inconsistent alignment with the others BIT(0) to BIT(4)

The alignment of all the values should be consistent.

Tom

>
> Regards,
> Richard
>
>> Tom
>>
>>>     /**
>>>    * struct fpga_image_info - information specific to a FPGA image
>>
>

