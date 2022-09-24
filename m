Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35475E8A2C
	for <lists+linux-fpga@lfdr.de>; Sat, 24 Sep 2022 10:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiIXI3k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 24 Sep 2022 04:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiIXI3j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 24 Sep 2022 04:29:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B39BC21;
        Sat, 24 Sep 2022 01:29:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f193so2305228pgc.0;
        Sat, 24 Sep 2022 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=H9XCRPFdXqUNtmAqhermX4cpbxgjD3c7QiDFM+/CVWY=;
        b=L+IBBWJm7mGDiOSPJIMesYOnEzlLQZvFMwAWErTLWcqud7pyVGr6XypYfSyB6hN+34
         PzVwtZIwrNQFfyRUgCUTuDoXecoQb4daIgwWik2QTtsmO+vDuQE3TWcj1kuCcXbb/3Cu
         U+1n7qHcWMAIwhoeYJftVORJ8hPu6GS396RLeFworHv0TuvNLlgdJQjSfvg7iyvrSD7f
         v5U6OBzYFURHQzezkrwvVQsKR1L1j0Ipt2A+vk38ONuHfbnHV8jldzHD0qQwvttUZdA5
         4YIxsr4VjgYGN2BlXI2ESBU2UlrlchJ7u6TpaTAl/3lrOC7wJr4aQBIvrqyXLEU1qTN1
         VzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H9XCRPFdXqUNtmAqhermX4cpbxgjD3c7QiDFM+/CVWY=;
        b=Y6+anBYwjUWZdY3rwrSdK+uYFItP7Mohyvbgi0E3S3pfoTcJ54KpqWQv70bdi65mzh
         UaIiWFrNWG3rTVctkm3BWj/v+vD0NMalKlA0MrHn9M+ptQbb87pteoO6Iuh6BDxgQD+M
         vWmzgDBfTI23Wntvt50PsHO3tMJjReH5pI7zEDfkvTbYFO+1vzum0pakmh2Mo3udovVP
         8a7jQGMtDWgAg7ZIBhBXhCKm/468bvjXLlST9nBTvfvZaG9XXi8/qj7kbMrge2rvPgfp
         QlFsZxZ2i/6AqnYKGNNMlx4DSBuL8ucf0C1bsZTlYAuH8snpjpX3mKmGRvyPvaUMtZKr
         yTHg==
X-Gm-Message-State: ACrzQf0k1QWzhlHZGtommawMbZA7Ha9g6cM04xs52MKXGh1VNNQXupqZ
        oZ36FumVSYz+z3WFLMLHBNQ=
X-Google-Smtp-Source: AMsMyM53KSErTl1m3UqDiFLr87+cKnvRRi113EC/U4YT1zYcRzBlbVl9uy7+/iCME4Pj13MrhZX28g==
X-Received: by 2002:a05:6a00:99c:b0:54c:27c4:3acb with SMTP id u28-20020a056a00099c00b0054c27c43acbmr12711258pfg.22.1664008177184;
        Sat, 24 Sep 2022 01:29:37 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902eb9200b0017872bc9865sm7162435plg.63.2022.09.24.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:29:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6A0AD1037EC; Sat, 24 Sep 2022 15:29:30 +0700 (WIB)
Date:   Sat, 24 Sep 2022 15:29:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 1/6] Documentation: fpga: dfl: Add documentation for
 DFHv1
Message-ID: <Yy6/6nPa8buvqvbp@debian.me>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
 <20220923121745.129167-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gILyyALDCOs9GF4/"
Content-Disposition: inline
In-Reply-To: <20220923121745.129167-2-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--gILyyALDCOs9GF4/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 05:17:40AM -0700, matthew.gerlach@linux.intel.com w=
rote:
> +With DFHv0, the register map of a given feature is located immediately f=
ollowing
> +the DFHv0 in the memory space.  With DFHv1, the location of the feature =
register
> +map can be specified as an offset to the DFHv1 or as an absolute address=
=2E  The DFHv1
> +structure is shown below:
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 =
ID 0|
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_L                          =
   0|
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_H                          =
   0|
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Address/Offset                            1|  Re=
l  0|
> +    +-------------------------------------------------------------------=
----+
> +    |63 Size of register set  32|Params 31|30 Group    16|15 Instance   =
   0|
> +    +-------------------------------------------------------------------=
----+
> +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID        =
   0|
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Parameter Data                                  =
   0|
> +    +-------------------------------------------------------------------=
----+
> +
> +                                  ...
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID        =
   0|
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Parameter Data                                  =
   0|
> +    +-------------------------------------------------------------------=
----+
> +

For consistency with DFL location diagram (which is above the DFHv1
diagram above), use literal code block instead of table:

---- >8 ----

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 7c786b75b4988f..db6bff4aee25eb 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -584,7 +584,7 @@ across all types.
 With DFHv0, the register map of a given feature is located immediately fol=
lowing
 the DFHv0 in the memory space.  With DFHv1, the location of the feature re=
gister
 map can be specified as an offset to the DFHv1 or as an absolute address. =
 The DFHv1
-structure is shown below:
+structure is shown below::
=20
     +---------------------------------------------------------------------=
--+
     |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID=
 0|

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--gILyyALDCOs9GF4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYy6/4wAKCRD2uYlJVVFO
o5KXAQCJ1UPL/CFnyL4a2ndyowwbvrWpIGVW1a8pRAsFnePQGwD8CNztDfBpOPJZ
1qnoSvaJGCUYL/4tQ+pvqPu1Dyn+JgA=
=P99G
-----END PGP SIGNATURE-----

--gILyyALDCOs9GF4/--
