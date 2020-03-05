Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1659C179E44
	for <lists+linux-fpga@lfdr.de>; Thu,  5 Mar 2020 04:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgCEDcS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 22:32:18 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39194 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgCEDcS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Mar 2020 22:32:18 -0500
Received: by mail-qv1-f65.google.com with SMTP id fc12so1831896qvb.6
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2020 19:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f8dpOPHCyl/LZIAkAf48i33FC43qWedgINTO0x8R9qc=;
        b=VzV1Ix9A2SZk2T0Vz9V3HCG4Y7jzwO2ZVdCzdH9OVfP05cltgH1fYDfnaUxGhfefLt
         sEsfT7oX2rIwA5flMRvi3iwwZqjR3rLtyA15Z2CLSuDni5i8v80eywBGqhJ5cH7RQcBw
         98sMaNsjyAhr7O6QivxxCqmFAP5yOmgUfzeOhnSSdLXsNtS8Y1ZnUHGwd5+kt9IfUevN
         LI9A4rmTj078WOvV2oNHqvetopK60q+m18srzZL+l49Hb3dbh38QX6cAOfsSt2ZUQd/k
         x3UggTuFbK97KqOy/uN7903/G8nNv8rPDwYtprd6gZi9SIZH+PIOViTM7KMjPFIeqoLn
         +45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f8dpOPHCyl/LZIAkAf48i33FC43qWedgINTO0x8R9qc=;
        b=EFCp6KutSH1oKG6QQSfSsObQoe12isFJdPtDfGUFCdJ+FB8u6SjTNQkUe3Fkyo4Vxd
         UMObZgQNo9QG7idVHeez3gTt4z4W9qJLZsMJtb4+KVq2lo6Fgeac2Kndy89FhQoQtHee
         qeso5T6VnNpZKQb4eRlw7mRvC3IF+bP0Q80QE2y2IEz18jh7C2n5fGRSl83ez6elbnz7
         eFbrzXpM1axQHCbdWDt0h8KYbUF5z6rT4Pa3utEKO2PRvwRo19iw5vXORCNvBZkdBDzx
         MURf91XgOBJn2ueTCc6F5NziCmNA2ZmZjQUTkuPr+qQ2H4chSJo+DkWcBHWhcO0K0E25
         d47A==
X-Gm-Message-State: ANhLgQ05fR+xfBy57LpgOMgjMdzWRA7P1SZ2zuEzpowG20AnNEpm2TtA
        GJyysSH1HqOzi71KeHvm7KQqlB2u
X-Google-Smtp-Source: ADFU+vvpPhzlKKjr2T63YOTFmYV6aaHA65yIAEMzKV8oCnVtSRR7gswxwCyyvcpr/QMx23/VemMHOQ==
X-Received: by 2002:a0c:f5ce:: with SMTP id q14mr4608801qvm.191.1583379136311;
        Wed, 04 Mar 2020 19:32:16 -0800 (PST)
Received: from [192.168.102.5] (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.googlemail.com with ESMTPSA id m17sm8561100qke.24.2020.03.04.19.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 19:32:15 -0800 (PST)
Subject: Re: [PATCH v2] fpga: dfl: afu: support debug access to memory-mapped
 afu regions
To:     Moritz Fischer <mdf@kernel.org>
Cc:     hao.wu@intel.com, linux-fpga@vger.kernel.org
References: <20200304133847.103881-1-d.c.ddcc@gmail.com>
 <20200305030926.GA4253@epycbox.lan>
From:   Dominic Chen <d.c.ddcc@gmail.com>
Autocrypt: addr=d.c.ddcc@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFbtu7sBCAC7ru9QmXnDTLz717MCDXn7pFPCFAEFsA7ryeU6CkztMi10bd910sHIIOkn
 Vr/qWNywDIZ/PO1bGQ+muVYXuT7XN3NQ3ei1+jIn/+VWkCSyVqDrwfF4E0egPqvrnYG20KIC
 sRkNrQQ+Sa64K2a0VVI2oamLWOsnAz7R9M7+ftpWYU4S7288ZNOVxFc8vxXUxPvnyVQ1NRRC
 hHZO1oVm73wAnxT0V2d7NHEIjiqRpHy8S4cL9CXmChwRcUnzEmLgd9uYjFHOLBI68opEV4cI
 l/x2z3hS3GNwCWbGyYCERJgi4oSknsUxFvQXIaY+irBr4Sf1G9lg0UbVJjiSP/mGVctJABEB
 AAG0KERhbWluZyBEb21pbmljIENoZW4gPGQuYy5kZGNjQGdtYWlsLmNvbT6JAUIEEwEIACwC
 GwMFCQlmAYAHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAUCVu28tgIZAQAKCRB2YcFbG47E
 OPwzB/45JF/Bj6InmsowqwXhgq8g7dPgPhK7n8dVehqrLce5T0FE03OdgNGYDKegci2UDgZu
 BUeFaJchbzg+WP5Wp5Jvb0NXeCV4GdzU8jUA4ggMDXk27yd6yg+iN3HXaiZXvxrunkP33/m8
 i7QO/FXB+11xp5lF2GkzicK6zy6VANLYKjqlfHTxN2k84pY/JQxxnLIbyZbSg/WS5KhWSUI1
 PXUpg+EwxnvVOpus12WawBEd8MrPC1/XoBhfLLu2lHScr0weUuvPbz1+OufxX1dvgFmYq4JW
 uKD4nrHHTsb+SFyY8XMlYKCXofRHJJcXnsGll6+L5XuqGdD1MCPxv+i9+q2EuQENBFbtu7sB
 CADO9FokrQssqyUgOGGxENd0Wr/NsuC8FO4YHYi6KJ+gYi0/XVPb5iyIywvw/i7KE+gFtVh8
 xfq7s42R8GIJ1q/zKcb1+8FkMB02Pe8Ju2s2u/A0KyUydA2IQ4weQpcCSSJhJLVI3URx1C1d
 pAg+3Bg6bZX0vORpIPS9POK6LOm83akmqL5EnTxQVjaiL5j9AQ+WO3bF8pYwuTTSaB9VmRu9
 IO4/QSzt2Hb3betitRjFiMOulXqyKKeLa46rcBzQo//tmtMfCDgEn7NosBO8VGG7W9PozBdC
 PXlL4Uc1k4WI1ROiTLb4XNxQ7VmDS+oZk2s7vjRiI6VniyCPSuuBm3TrABEBAAGJASUEGAEI
 AA8FAlbtu7sCGwwFCQlmAYAACgkQdmHBWxuOxDjmTgf/bGNKQxI90s6w+80Q09lhpvcNxi/S
 CNYTBtdYI0EfHfOMF9G2AdgGww/w9JpdYc+BAgxtJ7+wIOd7NkXrpmcABs2jB4XQicwFSpsb
 r7EAu1/5euAStLnOIKIS4/BKm7ABx4QsbPYOeK0xHrJbVdBzVfvpcQ6jrA9sbMRppRmkjUYy
 +XbaJOcDqNvkiSUSrC/xXXsvnPUTos0M4kZSWX3IpKknA6dg4YllA6nctvM+yqd2ACmVCoQT
 i6vDuNMWYc4kLhpx/2ZnVhQnRj3JHY046r0E94AP9zn907r+I/p173cETGzwD+98P61B7cMo
 8p9hsh8aCRhzGt3W8G+O87C2ZbkBDQRW7bxiAQgA01xauIP2YSOi0hT14zzGNJsZLZ4YonAm
 Os5vGsf5jtI0ay620NxE9SM7FF0cpYSkC1jz3pHugKWPEVO4Ru4xXzFx9smQ/rbusfWwHLWJ
 fYtDL3T/WCeluoffyJ8KsWfJh4rljxFBk3csNHakCFc+g75qrcFmKwzlpzYk2gizCYbI1H17
 NK0oK820dt3EjSC+Ve2VRl0voSdAgR+sJW6lR9zlzbEqv2CYYdLNBgO5IIJJsHzhlkiJ6WXW
 LaFB5IXcPGzy0TcxYKaREYWHIQQ3KM+8nUg14vQISvSQFbXBKivwB79B0u3k6TkUGBxkaBLx
 oKSGe5odK0V8JcJ497PaiQARAQABiQJEBBgBCAAPBQJW7bxiAhsCBQkJZgGAASkJEHZhwVsb
 jsQ4wF0gBBkBCAAGBQJW7bxiAAoJEAQIkkqKrpTGj3MIAIU/gdb8i73AbPecLPGbYMBhBdcd
 9VDidyY9JLOiRgjCsOFeqUoR2FML+3ipYGZ8YlH2X9SZ42lbZevbEYoXJzLojJOk6Ks1JKKo
 H9TYG8i1G77g0xl7T1YP2fy1XpEoEbN3GAdINoNphhMbUoY0rfLgBy06u0GmiatnmdaGY2JJ
 CntYauJGDI37JSF/iyP1NJbviieXhWZ9qJ6qyOJdNmFZtcWaZ6LVBGnmu2u8Lv36zVLqr5jW
 5lSsdNut43SeFgrZx4QyLEeVfHh3iM596s9BQlIpf9ITdjvFoLJX5Fi8BeowUkuZrGzDN5RV
 pXK7H3Xj9zsQ8HgJBKe5xjNEiXNwWgf+KmpCWQfcgiOah59Mk6x8dzv/2EWX18pN/EykwNxL
 2uIOlG6LDK177xHSDV/04vb/ZwE24o6Lk0AhdPn2xh49CuJUeBzxF5KlH4ti1bzK3AWlzhs9
 91YXcN7kZo+I3Uu3rw0nrynPuV4lRc7rSAc9akRPRDuMNJduAgDJKItZ7w1J0T4fHH0XN8Gf
 DTDxh/mc/qWFOsEJwe6CpiAZRhVXKzKPp7YuPKzj8XmaWaKf8dgQLYduFxMrSGLNRZP4OHoD
 CSatCSZbMTQW/P6vFKuCeHpkriI75pCa9YYB1m9Za33D5iMstqJ+j8J/5evaL4Pz7krTGowD
 SP1d4L0/7aR4qw==
Message-ID: <11d8fce0-f859-becc-f190-a151d4562e1c@gmail.com>
Date:   Wed, 4 Mar 2020 22:32:16 -0500
MIME-Version: 1.0
In-Reply-To: <20200305030926.GA4253@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 3/4/2020 10:09 PM, Moritz Fischer wrote:
>> +static const struct vm_operations_struct afu_vma_ops =3D {
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +	.access =3D generic_access_phys,
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
> I remember there were issues in the past with modules and this, are
> those resolved?

Are you referring to the `generic_access_phys` symbol not being
exported? It looks like it became available to GPL modules starting with
kernel v3.12.

>>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>>  {
>>  	struct platform_device *pdev =3D filp->private_data;
>> @@ -488,6 +494,9 @@ static int afu_mmap(struct file *filp, struct vm_a=
rea_struct *vma)
>>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>>  		return -EPERM;
>> =20
>> +	// Support debug access to the mapping
> Please use kernel style comments /* */ checkpatch.pl should catch this.=

Hmm, I did run checkpatch.pl, though it contains `$allow_c99_comments =3D=

1`.=C2=A0 I'll send out v3 to fix this.

Thanks,

Dominic


