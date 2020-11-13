Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2FA2B257A
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Nov 2020 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgKMU2L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Nov 2020 15:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgKMU2L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 13 Nov 2020 15:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605299289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4d0vkH2jDuVh6EaDMA0To+X9vsAdXrKKMJenCgweLo=;
        b=FBh6nkCD16uI04K60o6Jf9XFqocvWJAP6Rf+pRH72/VB80Jpv0fTKLuXk//VbDShP+F9bY
        7ihLaWnx0PVA2WNL3lYmSlTEJTjhJTpfDXtPwh9FZv/sYMpE18YSHkUKQdO1zZIzHKrny0
        4qtInQOpH79XYQ9WEHcJerguSxmNk+U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-qd8w3UI5OFeq6pC55J1Kmg-1; Fri, 13 Nov 2020 15:28:07 -0500
X-MC-Unique: qd8w3UI5OFeq6pC55J1Kmg-1
Received: by mail-qk1-f199.google.com with SMTP id w189so7400932qkd.6
        for <linux-fpga@vger.kernel.org>; Fri, 13 Nov 2020 12:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N4d0vkH2jDuVh6EaDMA0To+X9vsAdXrKKMJenCgweLo=;
        b=YMegJpXQV44l1puIupL/uUilEZIZPrr+ZDaNvbS2ulFngdZEcR2fMZWG0AzyXRXFfc
         F6J9z7w1DopPMoPJ8iRtk/fxkK6m8MwMeLJbkj/uPa7D5LZgVQqw0mprv1Hg5ufptjlW
         g3gTs1L1rqyPNDBhMS/s+qddxoW3YgDlnk+sE5KOWPNdjM9RtpWc7QbAVHC87kGP1Hab
         M7fbSg/13w82zG45zpZNUrlj3pngtyA/zbPEzv4Of95gZ5f0w0YzYrDz1KedfDF2l8Se
         yKlRnQWE5pYwcC+I96R3ZNw7sR12+5nuMitybYlUMcMQeGgGAZS0Wj90hAR9oe11qe5I
         SKrQ==
X-Gm-Message-State: AOAM530TAacxMiHyvCKAqXnzZ+2bH9u4p5tEi8eVmA/5vZwnI1uP1ru4
        EBQavnyhiBXtwpGaWgq4dX/LTpOsZk+g8Yq+/S8ntZ3t3MxFuIZ0iHgfBcbeQgbNDAb0QpNZ1Kk
        xwIEBF/AAPkfp/ijzLX6gYw==
X-Received: by 2002:a0c:ff28:: with SMTP id x8mr3795909qvt.46.1605299287273;
        Fri, 13 Nov 2020 12:28:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyH1HPtDvm4zxJ5teG+say4QQPsf31SE1HYPgNlKf4LmiEo6c5waFRcDwTqwrktk95SZP4V/w==
X-Received: by 2002:a0c:ff28:: with SMTP id x8mr3795896qvt.46.1605299287114;
        Fri, 13 Nov 2020 12:28:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w1sm6006071qta.34.2020.11.13.12.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:28:06 -0800 (PST)
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <94ccfc8d-ecf9-7782-9044-d3c0cb862118@redhat.com>
Date:   Fri, 13 Nov 2020 12:28:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Add authenticate-fpga-config property for FPGA bitstream authentication.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index e811cf8..7a512bc 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -187,6 +187,7 @@ Optional properties:
>  - external-fpga-config : boolean, set if the FPGA has already been configured
>  	prior to OS boot up.
>  - encrypted-fpga-config : boolean, set if the bitstream is encrypted
> +- authenticate-fpga-config : boolean, set if do bitstream authentication

The list is mostly in alphabetical order so the new 'authenticate-... ' should go at the top.

Improve what you mean by 'authentication' similar to my comment in the first patch.

Tom

>  - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>  	bridges to successfully become enabled after the region has been
>  	programmed.

