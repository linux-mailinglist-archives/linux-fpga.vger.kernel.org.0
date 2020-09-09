Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E00262FB7
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Sep 2020 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgIIOZr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Sep 2020 10:25:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54947 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728663AbgIIM67 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Sep 2020 08:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599656343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/8nQXqMfzr63L9sc34nY6dq0v4DgYlu4G8KpQeRN64=;
        b=A+xuqe5hb5AtgwmYcC62b6Yax4TN5N791ICesrqUsPT1y9UJHHFoImamZPzi6XEZ9whykJ
        ojQr8BthJ5Wc12YaM/TFCrCHc70nQaDdzUwTQTrSGATKpj280tsv94wJ0eUv8u12LRQd3k
        JDNTrd2MAPv+Nc5rSFOxPetd5hyhLHo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-ZOL9KoeXM7uvZ2jzEMVDHw-1; Wed, 09 Sep 2020 08:59:01 -0400
X-MC-Unique: ZOL9KoeXM7uvZ2jzEMVDHw-1
Received: by mail-qk1-f198.google.com with SMTP id v16so1301005qka.18
        for <linux-fpga@vger.kernel.org>; Wed, 09 Sep 2020 05:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1/8nQXqMfzr63L9sc34nY6dq0v4DgYlu4G8KpQeRN64=;
        b=jjP/a2usARTsKcbY655zEO+SdFqJwa6iIyHBwYzc99yrLHKwUtLslTTJ597QHOm/xt
         UXe/7V9k6IUVhZ+Q2c0el3YAtL6113TqEHNhHg4iG4C5McJMaKN/knM7ltjpQbMqsB5K
         1tTtyhAZPIZzqVi/ObClEpQu+dbMY+8lceRYXZU7JHzX4vkw476gMp5O+VksC5lzqCMN
         LOp8ET0L0lmdgvW6VQd6SKimF8Vw35ueqagKbxPlkR1TTQeswyTCpmB05b4aBcoQ2swA
         zE1nkc/BQN55bx8FHWRYKjp+b9LxQbWpu5Gv3dCv25LTb/mTjlWvzGXsrU0hCq+kw4pe
         zuSQ==
X-Gm-Message-State: AOAM530RinkLTNG8Fqlb/dRGgqux/j1hdWcV/4X5j3FI1eHY/hyTTZqS
        s/9FWxK+LkJxHDQStCBkTlURlYXUVQlN+f/n6zkGye/GK8CWWYuzAAx+2STa7YQmaqIP8jeW8w1
        VYO+7R7/YPW+VdDRFSoaxRg==
X-Received: by 2002:aed:35c4:: with SMTP id d4mr2989779qte.151.1599656341210;
        Wed, 09 Sep 2020 05:59:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4qqVvyKXPZHWb/Vt+ESzI0NqJrnhykvAageDbUvqZgLaFMO1gRVF6I1UCUh0UGu9Ofe529A==
X-Received: by 2002:aed:35c4:: with SMTP id d4mr2989765qte.151.1599656340954;
        Wed, 09 Sep 2020 05:59:00 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i7sm2553075qkb.131.2020.09.09.05.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:59:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] dfl: add dfl bus support to MODULE_DEVICE_TABLE()
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <31cffdc2-ed70-8f96-5501-08965d701535@redhat.com>
Date:   Wed, 9 Sep 2020 05:58:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1599544129-17594-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/7/20 10:48 PM, Xu Yilun wrote:
> Device Feature List (DFL) is a linked list of feature headers within the
> device MMIO space. It is used by FPGA to enumerate multiple sub features
Do you mean a linked list in the pci config space ?
> within it. Each feature can be uniquely identified by DFL type and
> feature id, which can be read out from feature headers.
>
> A dfl bus helps DFL framework modularize DFL device drivers for different
> sub features. The dfl bus matches its devices and drivers by DFL type and
> feature id.
>
> This patch add dfl bus support to MODULE_DEVICE_TABLE() by adding info
> about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
> point in file2alias.c.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  scripts/mod/devicetable-offsets.c |  4 ++++
>  scripts/mod/file2alias.c          | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 27007c1..d8350ee 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -243,5 +243,9 @@ int main(void)
>  	DEVID(mhi_device_id);
>  	DEVID_FIELD(mhi_device_id, chan);
>  
> +	DEVID(dfl_device_id);
> +	DEVID_FIELD(dfl_device_id, type);
> +	DEVID_FIELD(dfl_device_id, feature_id);
> +
>  	return 0;
>  }
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 2417dd1..0753fc2 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1368,6 +1368,18 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
>  	return 1;
>  }
>  
> +/* Looks like: dfl:tNfN */
> +static int do_dfl_entry(const char *filename, void *symval, char *alias)
> +{
> +	DEF_FIELD(symval, dfl_device_id, type);
> +	DEF_FIELD(symval, dfl_device_id, feature_id);
> +
> +	sprintf(alias, "dfl:t%01Xf%03X", type, feature_id);

Is it necessary to constrain the output here ?

If you do not want to use the full width of the types,

a comment would be helpful.

Tom

> +
> +	add_wildcard(alias);
> +	return 1;
> +}
> +
>  /* Does namelen bytes of name exactly match the symbol? */
>  static bool sym_is(const char *name, unsigned namelen, const char *symbol)
>  {
> @@ -1442,6 +1454,7 @@ static const struct devtable devtable[] = {
>  	{"tee", SIZE_tee_client_device_id, do_tee_entry},
>  	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
>  	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
> +	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
>  };
>  
>  /* Create MODULE_ALIAS() statements.

