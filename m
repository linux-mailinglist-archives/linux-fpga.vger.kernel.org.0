Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1321A09D
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jul 2020 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGINS1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jul 2020 09:18:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34540 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgGINS1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 9 Jul 2020 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594300705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uai31VQPEZN9rwf7OACVSGu+VKSktCcJq5Sw/CwzuWw=;
        b=EinuUTTlujbGjr4xZyU7p/wo+Mvxq0TMdHv+5P2e1gpyUW0SMyDS1xvHIiasSBiV5F/0cw
        VxjnbuRFNn4+2EksL1sM7E7/mTDEPPcnnOe2dhtz8P1SYsZQdeeqmrmYFKjTTTczgHmlj3
        A7RDdc9mo1FXIEJdR5CzcvT8x+wAFGA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-PX0D3fDANx29hI6K2gIwtQ-1; Thu, 09 Jul 2020 09:18:21 -0400
X-MC-Unique: PX0D3fDANx29hI6K2gIwtQ-1
Received: by mail-qk1-f199.google.com with SMTP id i6so1697218qkn.22
        for <linux-fpga@vger.kernel.org>; Thu, 09 Jul 2020 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uai31VQPEZN9rwf7OACVSGu+VKSktCcJq5Sw/CwzuWw=;
        b=Xqbx+O4ZIBUORl57ppVLbgPGQDxIBtzq817n85KVOTef/Uei5t9/AodtwTYiFOiUm8
         sDU49LcKngLnqYZwSaVh3gvPWjByZyf8us3+obudZzFRD9CLy+w3wecP0yTJLpMSBPm3
         6rozCyMylGrtVj+OeszHzWH4TMgdnHQa5YfJvL8IB3VdJeo9eTRDWkVmkBmPxcHgoEw8
         MkPxCn1lqzEGZwSA7qKj9dmlEhm7Ncj2gh0fXKCF46KtnP+iFgXGuG9MA5OEpo0g/U7P
         DhgReRX5xZtz7T741CebyI1/XUdpRIDmQvhVsVJL8cr8A9JUMGpLbOrc3tkJO9kIFc3z
         Q0lw==
X-Gm-Message-State: AOAM5337yRABVhiZ95ZJJp+4CYG3VEnyIJuRbMdLOHtnT4rZf423wlYw
        jlWCOPPMKXOoT0o9j/MndxDOqvkwQL6yqIlFWaArayjh3RkOLakXRkNDTc1C8nX4W6v9zVjfUqc
        5uOrPI21uu/yRBVKowJBbgw==
X-Received: by 2002:a37:8384:: with SMTP id f126mr63218165qkd.471.1594300701324;
        Thu, 09 Jul 2020 06:18:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7733/CHza1JSmzGYP3thc0Mpq3yjFhyLoQCKPyMkKUFdIFsXC4ZM3kw7kuIP92vg/wsKeMg==
X-Received: by 2002:a37:8384:: with SMTP id f126mr63218141qkd.471.1594300701089;
        Thu, 09 Jul 2020 06:18:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t57sm3733727qtc.91.2020.07.09.06.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:18:20 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/2] fpga: dfl: pci: reduce the scope of variable
 'ret'
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
 <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ef506ec6-d857-736b-e9e2-46077ab7d778@redhat.com>
Date:   Thu, 9 Jul 2020 06:18:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I think a better change is to use the ret variable, like this

--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -312,7 +312,7 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
                }
        }
 
-       return num_vfs;
+       return ret;
 }

The existing use of returning num_vfs is not right, the function should return 0/err not num_vfs. currently it is reusing the 0 passed in with num_vfs to mean disable as the 0 return status.  it should be properly returning ret.

Tom

On 7/9/20 1:12 AM, Xu Yilun wrote:
> This is to fix lkp cppcheck warnings:
>
>  drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
>     int ret = 0;
>         ^
>
>  drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
>     int ret = 0;
>             ^
>
> Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of cci_pci_sriov_configure")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4a14a24..73b5153 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -285,7 +285,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  {
>  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
>  	struct dfl_fpga_cdev *cdev = drvdata->cdev;
> -	int ret = 0;
>  
>  	if (!num_vfs) {
>  		/*
> @@ -297,6 +296,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  		dfl_fpga_cdev_config_ports_pf(cdev);
>  
>  	} else {
> +		int ret;
> +
>  		/*
>  		 * before enable SRIOV, put released ports into VF access mode
>  		 * first of all.

