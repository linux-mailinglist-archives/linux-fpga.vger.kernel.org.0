Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA522D7DC
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Jul 2020 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGYNaC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Jul 2020 09:30:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21260 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgGYNaB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 25 Jul 2020 09:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595683800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4a6saAc2T3vjUNyvSZ0iHlnUkwh1tHjNnDE13PD7ChM=;
        b=i+faLBacDoKVWx6sO3TeDJILullgCVbJDAXnu5m53GO+sPXH1I2FGaHavYjOhKBeoiai3f
        IdB+A5dSX6BjeDLMUq667O+rBDEaynKIoVAKC1h0t3YE2OqxWzFaO1qm5n7FCGDZ0AGoY0
        65cz5jq/nIGJ/lUC1aXqMzBR2ptsV5U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-TBPQ2hIGOry5Ud99wWI9Nw-1; Sat, 25 Jul 2020 09:29:58 -0400
X-MC-Unique: TBPQ2hIGOry5Ud99wWI9Nw-1
Received: by mail-qt1-f197.google.com with SMTP id i5so8004497qtw.3
        for <linux-fpga@vger.kernel.org>; Sat, 25 Jul 2020 06:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4a6saAc2T3vjUNyvSZ0iHlnUkwh1tHjNnDE13PD7ChM=;
        b=SYhym8CtUWLgodmu0/vxzZWuKMg14TqpWvmUUvzF0ouw91tyMTjjlmdizaGEBpRe2S
         90z4h0QZATIDaFPg35ytXPhNM4ygUtdkaJj6LAATDh/uVrJKHhf7uYWK7xq14R5ovWIO
         3mG0FNETCcN3XrBV4rt6VgHyaX1lm+o+fmYVAthM2RY18LaVKnJa46EVL9+dGlN1bi1A
         UykyqMiOsC6hMcHji8w1liAzyz8dFYhNcdMkGInYIRKstA0d39GCUWH5YKaOK3Y97195
         zuHgS8Y3yBfv00m8H6VijmjVsUtzrM11oqZF2gkUZiTVfI7BGhuZW5vqVno/aSKF8T6N
         TTxA==
X-Gm-Message-State: AOAM530Rp2k1XtQZe4wg9xR8AiMvYsl8r2111o1J8cSGd2JQQZHQ6XeR
        znDSwOx0UsMT6Un9/fTSVo1b+iGWyQIhPNAdMLRqLFWjew4I0s+7DxY+F4KbqelQ6ljmbPo+MbL
        AoCfu+vdY0ruFLkOppCOyYw==
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr14744084qve.66.1595683797896;
        Sat, 25 Jul 2020 06:29:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFmYa5HHP7PA+v6Ib9cPmMuTsmOO7MWKjGaDcNQrgAMIyuuqm+P8ouhyOp8outxf748BBVOQ==
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr14744068qve.66.1595683797671;
        Sat, 25 Jul 2020 06:29:57 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 65sm6287845qkn.103.2020.07.25.06.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 06:29:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] fpga: dfl: change data type of feature id to u16
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
Date:   Sat, 25 Jul 2020 06:29:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It would be good if the variable or element for the feature id had a consistent name.


> @@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
>   * @id: unique dfl private feature id.
>   */
>  struct dfl_feature_id {
> -	u64 id;
> +	u16 id;
>  };

Is this structure needed ?

Here is how it could be changed to 

struct dfl_feature_driver {

-    const dfl_feature_id *

+    const u16 *id_table;

...

Tom


>  
>  /**
> @@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
>   */
>  struct dfl_feature {
>  	struct platform_device *dev;
> -	u64 id;
> +	u16 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -371,7 +371,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
>  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
>  
>  static inline
> -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> +struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>  	struct dfl_feature *feature;
> @@ -384,7 +384,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
>  }
>  
>  static inline
> -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> +void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
>  
> @@ -395,7 +395,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
>  	return NULL;
>  }
>  
> -static inline bool is_dfl_feature_present(struct device *dev, u64 id)
> +static inline bool is_dfl_feature_present(struct device *dev, u16 id)
>  {
>  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
>  }

