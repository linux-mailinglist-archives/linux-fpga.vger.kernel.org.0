Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD217E78F
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Mar 2020 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCISxI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Mar 2020 14:53:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36355 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCISxI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Mar 2020 14:53:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id u25so10342923qkk.3
        for <linux-fpga@vger.kernel.org>; Mon, 09 Mar 2020 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Pv1fxiZ3vnU2srphzxtKYIYNaIxsgDZK94V3494XFYQ=;
        b=HiKryQpkh1qAb84SFsOI+J2ogkW/DTCo95aO+w+joPD0vmuNazrmnZ+3QkLnQOTtmH
         bsJDPnibYXNj4FYukIZyfDPmAAEk4qqfQabh+SXX/2pvtv999y7UAHFJxdUl9aW58aIQ
         ZGyTX5GO1cvwrwfUrXpMIavSFmOzBy6D9icolThXxHysHQM3VRFe8uL6Nh5LyQ33ahy5
         XxahRNKveLKGBDhrGyTkCVFQ1O+YrgALQZ4ZOx+TZz1bg2rrtfc/QZUaRGSv7+RJrzsF
         9zhyiIpO4vob8BDzKerUMSgsohMEufxsTs4H+WlSw99uGY1f7zhN+OqImumWrI6GmHfz
         0Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Pv1fxiZ3vnU2srphzxtKYIYNaIxsgDZK94V3494XFYQ=;
        b=uN8NwxTgvkDgkmXDDo+k69WX1znLi7VjCIcIzDT8X5sp3sOlmkraPSsWXX4XIfA8NC
         y1uQzIVAfAzvoo0fODbRJAuOB7ngjXRigdljHhqBRk2FNvRFN2ecMR4D14YcL5152fGY
         AUCeLUNYHct/MUiTATKaAXp0OU0zHgn7Ls61G0Gtqq2LPMia9pB+jCGqK7OQMvdlCi8n
         FmSxsnhjFsayR9T+TKq1U5lAxhwc85cdUHK4qawMA/8wTGsHjpIw4szY3+rnPKlfMpJS
         XzDlsj8CjfppqeJOVdXQ3WVl4dYUxPewrtBjkZPjyJDvox8X7siUg8qp4VLkXGSx8vCA
         xUWg==
X-Gm-Message-State: ANhLgQ0PzKITFp7mrnHwfxM+mWRS0sByPwVdBRb/TqQTLVmjBPcN4RqE
        ap3Kh8XNLVoREdZml+cb/3x2Kv/9
X-Google-Smtp-Source: ADFU+vumFYJL1HlLZHjB4nAhdXJx1AkR6dlGDd3WNDN9AcnzQ8xGYLSQikUcrdrmcEqapbNFAEsupA==
X-Received: by 2002:a37:bc82:: with SMTP id m124mr16748456qkf.477.1583779986515;
        Mon, 09 Mar 2020 11:53:06 -0700 (PDT)
Received: from [192.168.102.5] (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.googlemail.com with ESMTPSA id f93sm8001101qtd.26.2020.03.09.11.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 11:53:06 -0700 (PDT)
Subject: Re: [PATCH v3] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org
References: <20200305033310.117030-1-d.c.ddcc@gmail.com>
 <20200309072810.GA852@hao-dev>
From:   Dominic Chen <d.c.ddcc@gmail.com>
Autocrypt: addr=d.c.ddcc@gmail.com; prefer-encrypt=mutual; keydata=
 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
 SP1d4L0/7aR4qw==
Message-ID: <dca2ed7b-ff6e-2886-238b-6a924553b9f1@gmail.com>
Date:   Mon, 9 Mar 2020 14:53:05 -0400
MIME-Version: 1.0
In-Reply-To: <20200309072810.GA852@hao-dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/9/2020 3:28 AM, Wu Hao wrote:
> On Wed, Mar 04, 2020 at 10:33:10PM -0500, Dominic Chen wrote:
>> +static const struct vm_operations_struct afu_vma_ops = {
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +	.access = generic_access_phys,
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> To me, it's very clear for #ifdef - #end. So looks like this
> /* CONFIG_HAVE_IOREMAP_PROT */ comments is not needed.
>
> Could you please remove it? 
>
> Then
>
> Acked-by: Wu Hao <hao.wu@intel.com>
>
> Thanks
> Hao

Thanks, sent out v4.

Dominic

